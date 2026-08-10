############################################################################
# Example of Okta Terraform Module that creates a custom claim for         #
# the Custom Authorization Server associated with App with one environment #
# e.g. "SBX"                                                               #
############################################################################
module "app_claims" {
  source = "./m2m_claim" # path to the module folder

# In the ./m2m_claim folder, the resources.tf file retrieves the scopes required for creating the new claim
# A new claim is created and using Okta Update API, multiple profile labels are assigned to the claim depending on the environment

  default_basename = var.default_basename # User provides the Prefix of the App associated with the claim e.g. Test-App

  environments = var.environments # List consisting of the SBX environment for which the claim  is created e.g. ["SBX"]

  # env => client_id (== appId)
  apps_by_env = var.apps_by_env # List consisting of the Client ID for the app associated with the claims e.g. Test-App-SBX

  auth_server_id  = "default" # or your custom Auth Server ID
  custom_scopes   = var.custom_scopes # ensure these are what your M2M calls request
  okta_domain     = var.okta_domain # The Okta domain e.g. wcgappsdev.oktapreview.com

  # Choose one auth mode for the PUT:
  use_oauth_for_api = false
  okta_api_token    = var.okta_api_token
  org_name  = var.org_name
  base_url  = var.base_url

  # If using OAuth for the PUT, pass a valid bearer token instead:
  # use_oauth_for_api = true
  # oauth_bearer_token = var.okta_mgmt_bearer_token

  application_display_basename = var.application_display_basename # display basename for the app 'label' field. Most times similar to the default_basename
}
