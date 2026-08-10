# ── Provider is expected to be configured by the caller.

locals {
  # Map env => computed labels
  env_profile_label = {
    for env in var.environments :
    env => "App-${var.default_basename}-${upper(env)}"
  }

  env_display_label = {
    for env in var.environments :
    env => (
      var.application_display_basename != null
      ? "${var.application_display_basename}-${upper(env)}"
      : "${var.default_basename}-${upper(env)}"
    )
  }

  # Build a normalized map only for envs that have a client_id supplied
  work_items = {
    for env in var.environments :
    env => {
      client_id     = lookup(var.apps_by_env, env, null)
      profile_label = local.env_profile_label[env]
      display_label = local.env_display_label[env]
    }
    if contains(keys(var.apps_by_env), env)
  }
}

locals {
  auth_header = var.use_oauth_for_api ? "Authorization: Bearer ${var.oauth_bearer_token}" : "Authorization: SSWS ${var.okta_api_token}"
}
# ─────────────────────────────────────────────────────────────
# SCOPES (optional): create/manage only when manage_scopes = true
# If scopes already exist in the Custom AS (your current case), keep manage_scopes = false
# ─────────────────────────────────────────────────────────────
resource "okta_auth_server_scope" "scopes" {
  for_each       = var.manage_scopes ? toset(var.existing_scopes) : toset([])
  auth_server_id = var.auth_server_id

  name         = each.value
  display_name = each.value
  description  = "Custom scope ${each.value}"

  lifecycle {
    prevent_destroy = true
  }
}

# ─────────────────────────────────────────────────────────────
# SINGLE CLAIM: gated by user-provided scopes (no hardcoding)
# Appears only when one of var.claim_scopes is granted (unless always_include_claim = true)
# ─────────────────────────────────────────────────────────────
resource "okta_auth_server_claim" "app_claim" {
  auth_server_id = var.auth_server_id

  name       = "App-${var.default_basename}-Role"          # e.g., "${var.default_basename}-Role"
  claim_type = var.claim_type           # "RESOURCE" (access token) or "IDENTITY" (ID token)
  value_type = var.claim_value_type     # "EXPRESSION" or "GROUPS"
  value      = var.claim_value          # e.g., "app.profile.label"

  # Gate inclusion on the scopes provided by the caller
  scopes                  = var.custom_scopes
  always_include_in_token = var.always_include_claim

  # Only enforce dependency if this module is creating scopes
  depends_on = [okta_auth_server_scope.scopes]
}

# ─────────────────────────────────────────────────────────────
# Update each app's profile.label via Okta Apps API
# Keeps templatefile() as requested, and re-triggers on both inputs and template edits.
# ─────────────────────────────────────────────────────────────
resource "null_resource" "update_app_profile" {
  for_each = local.work_items

  # Re-run when inputs or the template file itself change
  triggers = {
    client_id       = each.value.client_id
    profile_label   = each.value.profile_label
    display_label   = each.value.display_label
    template_sha1   = filesha1("${path.module}/templates/update_app_payload.json.tmpl")
    payload_inputs  = sha1(jsonencode({
      client_id     = each.value.client_id
      profile_label = each.value.profile_label
      display_label = each.value.display_label
    }))
  }

  provisioner "local-exec" {
    when    = create
    command = <<-EOT
      set -euo pipefail
      BODY_FILE="$(mktemp)"

      # Render the exact payload your Okta Apps API expects
      cat > "$BODY_FILE" <<'JSON'
      ${templatefile("${path.module}/templates/update_app_payload.json.tmpl", {
        client_id     = each.value.client_id,
        profile_label = each.value.profile_label,
        display_label = each.value.display_label
      })}
JSON

      curl -sS -X PUT "https://${var.okta_domain}/api/v1/apps/${each.value.client_id}" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -H "${local.auth_header}" \
        --data @"$BODY_FILE" \
        --fail --show-error --location >/dev/null

      rm -f "$BODY_FILE"
    EOT
    interpreter = ["/usr/bin/env", "bash", "-c"]
  }
}