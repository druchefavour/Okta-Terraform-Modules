resource "okta_app_oauth" "m2m_apps" {
for_each = local.effective_m2m_apps

  label = each.value.label

  type             = var.type 
  grant_types      = var.grant_types
  token_endpoint_auth_method = var.auth_method
  auto_key_rotation = var.key_rotation
  
}
