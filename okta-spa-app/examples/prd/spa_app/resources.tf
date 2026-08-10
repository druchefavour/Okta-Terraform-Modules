resource "okta_app_oauth" "spa_apps" {
for_each = local.effective_spa_apps

  label = each.value.label

  type             = var.type 
  grant_types      = var.grant_types
  redirect_uris    = each.value.redirect_uris
  post_logout_redirect_uris = each.value.post_logout_uris
  response_types   = var.response_types
  token_endpoint_auth_method = var.auth_method
  auto_key_rotation = var.key_rotation
  pkce_required = true
}
