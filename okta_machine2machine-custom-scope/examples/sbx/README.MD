# THis Okta Terraform Module creates a custom scope related to an application in the sandbox environment in Okta for the custom authorization server 

# Preview Tenant (https://wcgappsdev.oktapreview.com)
# (e.g., sbx). 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.auth_server_id
   Okta Authorization Server ID where scopes will be created.
   Enter a value: default

2. Second input request var.envs
   Environments for which to create scopes.

    # Preview
   Enter a value:["SBX"]

3. Third input request: var.label
   Application label part of the scope name (e.g., 'Test_M2M-BE').

   Enter a value: Test_M2M-BE

4. Fourth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:

5. Second input request: var.base_url
   okta subdomain.
   Enter a value: e.g. oktapreview.com (Preview)

6. Sixth input request: var.org_name
   okta org name.
   Enter a value: wcgappsdev for the Preview Tenant

# Preview Tenant (https://wcgapps.okta.com and https://preview.wcgclinical.com)
Entering the multiple environments for the Preview Tenant produces a plan for  Test_M2M-BE-SBX:
Terraform used the selected providers to
generate the following execution plan.
Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.custom_scopes.okta_auth_server_scope.scopes["SBX"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for TEst-M2M-BE in SBX"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["SBX"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to answer the question: "Do you want to perform these actions?" type "yes" to successfully create the scopes for app: Test_M2M-BE-SBX (Preview)