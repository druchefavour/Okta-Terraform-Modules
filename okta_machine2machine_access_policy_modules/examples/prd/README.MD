# THis Okta Terraform Module creates an Okta Access Policy related to applications in PRD environment 

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
# (e.g., prd). 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan
1. First input request: var.base_url
   okta subdomain.
   Enter a value: okta.com (Production)
2. Second input request: var.client_labels_by_env
   Map of environment => Okta OAuth app label. If empty, defaults to '<basename>-<ENV>'.
  
   # Production
   Enter a value: {"PRD" = "Trial-IntelXE-BE-PRD"}
  
3. Third input request: var.default_basename
   Base name used to build policy and rule names, and (by default) client labels.
   Enter a value: Trial-IntelXE-BE
  
4. Fourth input request: var.envs
   Ordered list of environments to configure

   # Production
   Enter a value: ["PRD"]

5. Fifth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:

6. Sixth request: var.org_name
   okta org name.
   Enter a value: wcgapps for the Production Tenant 

7. Seventh input request: var.scopes_by_env
  Map of environment => list of existing scope names to allow.
  Example:
  {
    SBX = ["Trial-IntelXE-SBX-123..."]
    DEV = ["Trial-IntelXE-DEV-123..."]
    TST = ["Trial-IntelXE-TST-123..."]
  }

# Production
 {"PRD" = ["Trial-IntelXE-BE-PRD-1788d8bc-a628-3dea-37dd-7c42a79fda68"]}

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)

Entering the PRD environment for the Production Tenant produces a plan for Trial-IntelXE--PRD

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

Plan: 2 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the the Access Polic for apps: Trial-IntelXE-BE-PRD (Production)