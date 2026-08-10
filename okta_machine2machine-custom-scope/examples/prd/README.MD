# THis Okta Terraform Module creates a custom scope related to an application in the production environment in Okta for the custom authorization server 

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
# (e.g., prd). 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pcks2.pem)" ) if the PRIVATE KEY is pcks2.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.auth_server_id
   Okta Authorization Server ID where scopes will be created.
   Enter a value: default

2. Second input request var.envs
   Environments for which to create scopes.

   # Production
   Enter a value: ["PRD"]

3. Third input request: var.label
   Application label part of the scope name (e.g., 'Test_M2M-BE').

   Enter a value: Test_M2M-BE

4. Fourth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:

5. Second input request: var.base_url
   okta subdomain.
   Enter a value: e.g. okta.com (Production)

6. Sixth input request: var.org_name
   okta org name.
   Enter a value: wcgapps for the Production Tenant 

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
Entering the PRD environment for the Production Tenant produces a plan for Test_M2M-BE-PRD:


Terraform used the selected providers to
generate the following execution plan.
Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.custom_scopes.okta_auth_server_scope.scopes["PRD"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in PRD"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["PRD"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to answer the question: "Do you want to perform these actions?" type "yes" to successfully create the scopes for app: Test_M2M-BE-PRD (Production)