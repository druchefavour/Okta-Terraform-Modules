# THis Okta Terraform Module creates an Okta Access Policy related to applications in multiple environments 

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
1. First input request: var.base_url
   okta subdomain.
   Enter a value: oktapreview.com (Preview) or okta.com (Production)
2. Second input request: var.client_labels_by_env
   Map of environment => Okta OAuth app label. If empty, defaults to '<basename>-<ENV>'.
   # Preview
   Enter a value: {"SBX" = "Trial-IntelXE-BE-SBX", "DEV" = "Trial-IntelXE-BE-DEV", "TST" = "Trial-IntelXE-BE-TST", "UAT" = "Trial-IntelXE-BE-UAT", "BTA" = "Trial-IntelXE-BE-BTA" }

   # Production
   Enter a value: {"PRD" = "Trial-IntelXE-BE-PRD", "TRN" = "Trial-IntelXE-BE-TRN"}
  
3. Third input request: var.default_basename
   Base name used to build policy and rule names, and (by default) client labels.
   Enter a value: Trial-IntelXE-BE
  
4. Fourth input request: var.envs
   Ordered list of environments to configure

   # Preview
   Enter a value:["SBX", "DEV", "TST", "UAT", "BTA"]

   # Production
   Enter a value: ["PRD", "TRN"]

5. Fifth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:

6. Sixth request: var.org_name
   okta org name.
   Enter a value: wcgappsdev for the Preview Tenant or wcgapps for the Production Tenant 

7. Seventh input request: var.scopes_by_env
  Map of environment => list of existing scope names to allow.
  Example:
  {
    SBX = ["Trial-IntelXE-SBX-123..."]
    DEV = ["Trial-IntelXE-DEV-123..."]
    TST = ["Trial-IntelXE-TST-123..."]
  }

  # Preview
  {
   SBX = ["Trial-IntelXE-BE-SBX-ff657355-d17c-e363-6eea-d4387a2f9eec"], 
   DEV = ["Trial-IntelXE-BE-DEV-4ac2610d-9fa0-d741-7643-7b6e1694b722"],
   TST = ["Trial-IntelXE-BE-TST-12678d00-5b31-d659-972b-5dd5e250a919"],
   UAT = ["Trial-IntelXE-BE-UAT-eb5a5f90-1f8a-28f1-e51e-bdcee94c3116"],
   BTA = ["Trial-IntelXE-BE-BTA-fba53d8d-06ab-a396-18a3-91d50df3d349"]
} 

# Production
 {
    "PRD" = ["Trial-IntelXE-BE-PRD-1788d8bc-a628-3dea-37dd-7c42a79fda68"],
    "TRN" = ["Trial-IntelXE-BE-TRN-0a6b674d-8dce-1a01-9116-bf9a93d79533"]
  }

# Preview Tenant (https://wcgapps.okta.com and https://preview.wcgclinical.com)
Entering the multiple environments for the Preview Tenant produces a plan for  Trial-IntelXE-BE-SBX, Trial-IntelXE-BE-DEV, Trial-IntelXE-BE-TST, Trial-IntelXE-BE-UAT and Trial-IntelXE-BE-BTA:

Terraform used the selected providers to
generate the following execution plan.
Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.m2m_access_policy.okta_auth_server_policy.this will be created
  + resource "okta_auth_server_policy" "this" {
      + auth_server_id   = "default"
      + client_whitelist = [
          + "0oavpu12i5HQFI0ED1d7",
          + "0oavpu220gKBUKCSt1d7",
          + "0oavpu34nl93RyJEH1d7",
          + "0oavpu3keqVxf666q1d7",
          + "0oavpucqhom1GVh391d7",
        ]
      + description      = "Access Policy for Trial-IntelXE-BE applications"
      + id               = (known after apply)
      + name             = "Trial-IntelXE-BE-Access-Policy"
      + priority         = 1
      + status           = "ACTIVE"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["BTA"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-BTA-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 14
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-BTA-fba53d8d-06ab-a396-18a3-91d50df3d349",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["DEV"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-DEV-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 11
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-DEV-4ac2610d-9fa0-d741-7643-7b6e1694b722",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["SBX"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-SBX-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 10
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-SBX-ff657355-d17c-e363-6eea-d4387a2f9eec",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["TST"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-TST-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 12
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-TST-12678d00-5b31-d659-972b-5dd5e250a919",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["UAT"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-UAT-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 13
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-UAT-eb5a5f90-1f8a-28f1-e51e-bdcee94c3116",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)

Entering the multiple environments for the Production Tenant produces a plan for AIMS-ECM-BE-PRD, AIM-ECM-BE-TRN:

Terraform used the selected providers to
generate the following execution plan.
Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.m2m_access_policy.okta_auth_server_policy.this will be created
  + resource "okta_auth_server_policy" "this" {
      + auth_server_id   = "default"
      + client_whitelist = [
          + "0oa21m7v2jmGNtvhC1d8",
          + "0oa21m7w3l41fBqYJ1d8",
        ]
      + description      = "Access Policy for Trial-IntelXE-BE applications"
      + id               = (known after apply)
      + name             = "Trial-IntelXE-BE-Access-Policy"
      + priority         = 1
      + status           = "ACTIVE"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["PRD"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-PRD-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 10
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-PRD-1788d8bc-a628-3dea-37dd-7c42a79fda68",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

  # module.m2m_access_policy.okta_auth_server_policy_rule.env_rules["TRN"] will be created
  + resource "okta_auth_server_policy_rule" "env_rules" {
      + access_token_lifetime_minutes  = 60
      + auth_server_id                 = "default"
      + grant_type_whitelist           = [
          + "client_credentials",
        ]
      + id                             = (known after apply)
      + name                           = "Trial-IntelXE-BE-TRN-Access-Rule"
      + policy_id                      = (known after apply)
      + priority                       = 11
      + refresh_token_lifetime_minutes = 129600
      + refresh_token_window_minutes   = 10080
      + scope_whitelist                = [
          + "Trial-IntelXE-BE-TRN-0a6b674d-8dce-1a01-9116-bf9a93d79533",
        ]
      + status                         = "ACTIVE"
      + system                         = (known after apply)
      + type                           = "RESOURCE_ACCESS"
    }

Plan: 3 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the Access Policy for apps: Trial-IntelXE-BE-SBX, Trial-IntelXE-BE-DEV, Trial-IntelXE-BE-TST, Trial-IntelXE-BE-UAT and Trial-IntelXE-BE-BTA (Preview) and Trial-IntelXE-BE-PRD, Trial-IntelXE-BE-TRN (Production)