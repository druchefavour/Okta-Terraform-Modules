##########################################################################
# Module to create Access Policies and Access Rules for applications in  #
# multiple environments the Cusstom Authorization Server                 #
##########################################################################

module "m2m_access_policy" {
  source = "./m2m_access_policy" #  path to the module folder
  
  # In the ./m2m_access_policy folder, the resources.tf creates the access policy and access rules for each 9f the environments 

  okta_api_token    = var.okta_api_token
  org_name  = var.org_name
  base_url  = var.base_url

  scopes_by_env = var.scopes_by_env # list of existing custom scope names to allow
  default_basename = var.default_basename # Base name used to build policy and rule names, and (by default) client labels.
  auth_server_id   = "default"

  # Environments to manage
  envs = var.envs # Ordered list of environments to configure

  # Option A: let the module find clients by label "<basename>-<ENV>" (no extra inputs needed)
  # Optionally override labels explicitly:
  client_labels_by_env = var.client_labels_by_env # Okta OAuth app label. If empty, defaults to '<basename>-<ENV>'
}