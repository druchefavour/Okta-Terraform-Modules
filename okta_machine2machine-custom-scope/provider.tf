# provider.tf (example)
provider "okta" {
  org_name  = var.okta_org_name
  base_url  = var.okta_base_url   # e.g., "okta.com"
  api_token = var.okta_api_token  # or configure OAuth service app
}


