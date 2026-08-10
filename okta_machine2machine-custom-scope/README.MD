# THis Okta Terraform Module creates an multiple custom scopes related to applications in multiple environments in Okta for the custom authorization server 

# Preview Tenant (https://wcgappsdev.oktapreview.com or https://preview.wcgclinical.com)
# (e.g., sbx, dev, tst, uat and bta). 

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
# (e.g., prd, trn). 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.auth_server_id
   Okta Authorization Server ID where scopes will be created.
   Enter a value: default

2. Second input requestvar.envs
   Environments for which to create scopes.

    # Preview
   Enter a value:["SBX", "DEV", "TST", "UAT", "BTA"]

   # Production
   Enter a value: ["PRD", "TRN"]

3. Third input request: var.label
   Application label part of the scope name (e.g., 'Test_M2M-BE').

   Enter a value: Test_M2M-BE

4. Fourth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:

5. Second input request: var.base_url
   okta subdomain.
   Enter a value: e.g. oktapreview.com (Preview) okta.com (Production)

6. Sixth input request: var.org_name
   okta org name.
   Enter a value: wcgappsdev for the Preview Tenant or wcgapps for the Production Tenant 

  
# Preview Tenant (https://wcgapps.okta.com and https://preview.wcgclinical.com)
Entering the multiple environments for the Preview Tenant produces a plan for  Test_M2M-BE-SBX, Test_M2M-BE-DEV, Test_M2M-BE-TST, Test_M2M-BE-UAT and Test_M2M-BE-BTA:

Terraform used the selected providers to
generate the following execution plan.
Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.custom_scopes.okta_auth_server_scope.scopes["BTA"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in BTA"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.okta_auth_server_scope.scopes["DEV"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in DEV"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.okta_auth_server_scope.scopes["SBX"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in SBX"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.okta_auth_server_scope.scopes["TST"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in TST"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.okta_auth_server_scope.scopes["UAT"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in UAT"
      + display_name     = (known after apply)
      + id               = (known after apply)
      + metadata_publish = "NO_CLIENTS"
      + name             = (known after apply)
      + system           = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["BTA"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["DEV"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["SBX"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["TST"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

  # module.custom_scopes.random_uuid.scope_guid["UAT"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

Plan: 10 to add, 0 to change, 0 to destroy.

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
Entering the multiple environments for the Production Tenant produces a plan for Test_M2M-BE-PRD, Test_M2M-BE-TRN:

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

  # module.custom_scopes.okta_auth_server_scope.scopes["TRN"] will be created
  + resource "okta_auth_server_scope" "scopes" {
      + auth_server_id   = "default"
      + consent          = "IMPLICIT"
      + default          = false
      + description      = "Custom scope for Test-M2M-BE in TRN"
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

  # module.custom_scopes.random_uuid.scope_guid["TRN"] will be created
  + resource "random_uuid" "scope_guid" {
      + id     = (known after apply)
      + result = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to answer the question: "Do you want to perform these actions?" type "yes" to successfully create the scopes for apps: Test_M2M-BE-SBX, Test_M2M-BE-DEV, Test_M2M-BE-TST, Test_M2M-BE-UAT and Test_M2M-BE-BTA (Preview) and Test_M2M-BE-PRD, Test_M2M-BE-TRN (Production)

# OPERATION DETAILS
Create a terraform module for Okta custom scope.
Scopes to be create for an application in multiple environments: sbx, dev, tst, uat and bta
The scope name will be in the format: Label-<env>-GUID. For instance if the label for the application is Test_App, the scopes will be Test_M2M-BE-SBX-GUID, Test_M2M-BE-DEV-GUID, Test_M2M-BE-TST-GUID etc. GUID is randomnly generated. 