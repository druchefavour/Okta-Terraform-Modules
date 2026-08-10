###############################################################################################
# Example of the Module applied to create a custom scope for the Cusstom Authorization Server #
# for the PRD environment only                                                                #
###############################################################################################


module "custom_scopes" {
  source         = "./m2m_scope" # path to the internal folder

  # Choose one auth mode for the PUT:
 okta_api_token = var.okta_api_token
 okta_org_name = var.okta_org_name
 okta_base_url = var.okta_base_url

  # If using OAuth for the PUT, pass a valid bearer token instead:
  # use_oauth_for_api = true
  # oauth_bearer_token = var.okta_mgmt_bearer_token

# In the ./m2m_scope folder, the resources.tf file creates scope names using the labels created in locals.tf for each environment
# The labels are further conctaneted with random generated GUIDS to create the scopes.

label          = var.label # Application label part of the scope name (e.g., 'Test_M2M-BE')."

auth_server_id = var.auth_server_id # Okta Custom Authorization Server ID where scopes will be created."

envs        = var.envs # Environments for which to create scopes.

consent        = "IMPLICIT"

metadata_publish = "NO_CLIENTS"

default_scope  = false
}
