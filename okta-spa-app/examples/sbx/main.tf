# Use terraform files located in the root and spa_app folder

###############################################
# 1) Single Page Application (SPA) app (confidential client)
###############################################
module "spa" {
  source = "./spa_app/"
  
  # Use providers from providers.tf
    # Use variables from variables.tf.
    # Use the versions from versions.tf

    # The module creates apps in multiple environments by calling ./spa_app/resources.tf 
  # The ./spa_app/locals.tf contains script that creates the effective app. The user input includes definition of the variable (located in ./m2m_app/variables.tf) for the environments to be created:
  # e.g 

   # spa_apps= { "sbx" = {}, "dev" = {}, tst = {}, "uat" = {}, "bta" = {}} for five environments and
   # spa apps: { "sbx" = {}} for just the sandbox environment

  # /spa_app/locals.tf also requires a user input: default_label_basename, which is the prefix of the app. 
  # Use /spa_app/variables.tf to define all the variables required in /spa_app/locals.tf and /spa_app/resources.tf
  
  # Use ./spa_app/outputs.tf to create output files (client id and the app name)

  # User-provided # User-provided defaults 

  OKTA_ORG_NAME = var.OKTA_ORG_NAME
  OKTA_BASE_URL = var.OKTA_BASE_URL
  OKTA_API_CLIENT_ID = var.OKTA_API_CLIENT_ID
  OKTA_API_SCOPES      = var.OKTA_API_SCOPES
  OKTA_API_PRIVATE_KEY = var.OKTA_API_PRIVATE_KEY

  // User-provided defaults (these are required since the module has no defaults)
  default_label_basename   = var.default_label_basename
  default_redirect_uris    = var.default_redirect_uris
  default_post_logout_uris = var.default_post_logout_uris

  // Decide which apps to create; override only what you need
  spa_apps = var.spa_apps
}
