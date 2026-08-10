locals {
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


# Prepare a map of client_ids by env:
# If user provides client_ids_by_env explicitly, prefer them.
# Otherwise, use the IDs discovered by label lookups above.
# locals {
   # effective_client_ids_by_env = length(var.client_ids_by_env) > 0
    # ? var.client_ids_by_env
    # : { for e in var.envs : e => data.okta_app_oauth.clients[e].client_id }
# }
