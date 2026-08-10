/*locals {
  # If explicit client labels are not provided, derive labels as "<basename>-<ENV>"
  derived_client_labels_by_env = {
    for e in var.envs : e => "${var.default_basename}-${e}"
  }

  # Keep the entire ternary on one line:
  effective_client_labels_by_env = length(var.client_labels_by_env) > 0 ? var.client_labels_by_env : local.derived_client_labels_by_env
}

# Resolve OAuth client IDs by label (recommended)
# (One lookup per environment)
data "okta_app_oauth" "clients" {
  for_each = toset(var.envs)
  label    = local.effective_client_labels_by_env[each.key]
}

locals {
  # Prefer explicit client IDs if provided; else fall back to discovered IDs
  effective_client_ids_by_env = length(var.client_ids_by_env) > 0 ? var.client_ids_by_env : { for e in var.envs : e => data.okta_app_oauth.clients[e].client_id }
}
*/
# -------------------------
#      ACCESS POLICY
# -------------------------
# NOTE: No client_whitelist here (by design).
resource "okta_auth_server_policy" "this" {
  auth_server_id = var.auth_server_id
  name           = "${var.default_basename}-Access-Policy"
  description    = "Access Policy for ${var.default_basename} applications"
  status         = var.status
  client_whitelist = values(local.effective_client_ids_by_env)
  //client_whitelist       = [local.effective_client_ids_by_env[each.key]]
  priority       = var.policy_priority
}

resource "okta_auth_server_policy_rule" "env_rules" {
  for_each = toset(var.envs)

  auth_server_id = var.auth_server_id
  policy_id      = okta_auth_server_policy.this.id
  status                 = var.status
  name           = "${var.default_basename}-${each.key}-Access-Rule"

  priority = lookup(var.rule_priority_by_env, each.key, 10 + index(var.envs, each.key))

  # Per‑env client(s):
  //client_whitelist       = [local.effective_client_ids_by_env[each.key]]
  grant_type_whitelist   = ["client_credentials"]
  scope_whitelist        = lookup(var.scopes_by_env, each.key, [])


  
  access_token_lifetime_minutes   = var.access_token_lifetime_minutes
  refresh_token_lifetime_minutes  = var.refresh_token_lifetime_minutes
  #refresh_token_idle_minutes      = var.refresh_token_idle_minutes
}
