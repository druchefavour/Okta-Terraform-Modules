# Use scripts from m2m-app
###############################################
# 1) M2M app (confidential client)
###############################################
module "m2m" {
  source = "./m2m_app"
  # Use providers from providers.tf
  # Use variables from variables.tf.
  # Use the versions from versions.tf

  # The module creates apps in multiple environments by calling ./m2m_app/resources.tf 
  # The ./m2m_app/locals.tf contains script that creates the effective app. The user input includes definition of the variable (located in ./m2m_app/variables.tf) for the environments to be created:
  # e.g 
  /*m2m apps: {
    "sbx" = {},
    dev = {}
    tst = {}
    uat = {}
    bta = {}
  }*/
  #for five environments and
  /*m2m apps: {
    "sbx" = {}
    }*/
  # for just the sandbox environment
  # /m2m_app/locals.tf also requires a user input: default_label_basename, which is the prefix of the app. 
  # Use /m2m_app/variables.tf to define all the variables required in /m2m_app/locals.tf and /m2m_app/resources.tf

# Use ./m2m_app/outputs.tf to create output files (client id and the app name)

# User-provided # User-provided defaults 
  OKTA_ORG_NAME = var.OKTA_ORG_NAME
  OKTA_API_PRIVATE_KEY = var.OKTA_API_PRIVATE_KEY
  OKTA_BASE_URL = var.OKTA_BASE_URL
  OKTA_API_CLIENT_ID = var.OKTA_API_CLIENT_ID
  OKTA_API_SCOPES = var.OKTA_API_SCOPES

  # User-provided defaults (these are required since the module has no defaults)

  default_label_basename   = var.default_label_basename

  # Decide which apps to create; override only what you need
  m2m_apps = var.m2m_apps
}
