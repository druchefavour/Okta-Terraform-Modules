# Create one custom scope per environment on the specified Authorization Server
resource "okta_auth_server_scope" "scopes" {
  for_each        = local.scope_names
  auth_server_id  = var.auth_server_id
  name            = each.value

  # Optional UX niceties / governance
  display_name    = coalesce(var.display_name, each.value)
  description     = coalesce(var.description, "Custom scope for ${var.label} in ${upper(each.key)}")
  consent         = var.consent          # "IMPLICIT" or "REQUIRED"
  metadata_publish = var.metadata_publish # "ALL_CLIENTS" or "NO_CLIENTS"
  default         = var.default_scope    # boolean

  lifecycle {
    # You usually don't want scope names to be replaced if description changes, etc.
    # Customize ignore_changes as your policy dictates.
  }
}
