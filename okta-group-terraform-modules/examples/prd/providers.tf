provider "okta" {
  org_name    = var.OKTA_ORG_NAME
  base_url    = var.OKTA_BASE_URL
  client_id   = var.OKTA_API_CLIENT_ID
  scopes      = var.OKTA_API_SCOPES
  private_key = var.OKTA_API_PRIVATE_KEY
}
