
# Use terraform files located in the root and okta-groups folder

###############################################
# 1) Create Okta Groups
###############################################

# Use providers from providers.tf
# Use variables from variables.tf.
# Use the versions from versions.tf

# The module is an example of the Terraform module that creates Okta groups in the Sandbox environment using okta-groups/resources.tf 
# The ./okta-groups/resources.tf contains script that creating groups with var.envs comprising the list of environments required for group creation 
# e.g. var.envs = ["SBX"]

# It also contains var.apps = ["App"] which is the default prefix for every Okta application group.
# It contains var.default_basename which is the prefix of the associated app. and 

# Use /okta-groups/variables.tf to define all the variables required in /okta-groups/resources.tf
  

# User-provided defaults 

module "my_okta_groups" {
  source            = "./okta-groups"
# User-provided defaults   
  OKTA_API_TOKEN = var.OKTA_API_TOKEN
  OKTA_ORG_NAME = var.OKTA_ORG_NAME
  OKTA_BASE_URL = var.OKTA_BASE_URL
  OKTA_API_CLIENT_ID = var.OKTA_API_CLIENT_ID
  OKTA_API_SCOPES      = var.OKTA_API_SCOPES
  OKTA_API_PRIVATE_KEY = var.OKTA_API_PRIVATE_KEY

# User-provided defaults   
  app               = var.app
  default_basename  = var.default_basename
  envs              = var.envs
}
