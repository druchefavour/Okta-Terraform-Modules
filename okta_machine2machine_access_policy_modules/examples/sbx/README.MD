# THis Okta Terraform Module creates an Okta Access Policy related to applications in SBX environment 

# Preview Tenant (https://wcgappsdev.oktapreview.com or https://preview.wcgclinical.com)
# (e.g., sbx). 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan
1. First input request: var.base_url
   okta subdomain.
   Enter a value: oktapreview.com (Preview)
2. Second input request: var.client_labels_by_env
   Map of environment => Okta OAuth app label. If empty, defaults to '<basename>-<ENV>'.
   # Preview
   Enter a value: {"SBX" = "Trial-IntelXE-BE-SBX" }
  
3. Third input request: var.default_basename
   Base name used to build policy and rule names, and (by default) client labels.
   Enter a value: Trial-IntelXE-BE
  
4. Fourth input request: var.envs
   Ordered list of environments to configure

   # Preview
   Enter a value:["SBX"]

5. Fifth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:

6. Sixth request: var.org_name
   okta org name.
   Enter a value: wcgappsdev for the Preview Tenant

7. Seventh input request: var.scopes_by_env
  Map of environment => list of existing scope names to allow.
  Example:
  {
    SBX = ["Trial-IntelXE-SBX-123..."]
    DEV = ["Trial-IntelXE-DEV-123..."]
    TST = ["Trial-IntelXE-TST-123..."]
  }

  # Preview
  {SBX = ["Trial-IntelXE-BE-SBX-ff657355-d17c-e363-6eea-d4387a2f9eec"]} 

# Preview Tenant (https://wcgapps.okta.com and https://preview.wcgclinical.com)
Entering the multiple environments for the Preview Tenant produces a plan for  Trial-IntelXE-BE-SBX,

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
          + "0oavpu3keqVxf666q1d7",
        ]
      + description      = "Access Policy for Trial-IntelXE-BE applications"
      + id               = (known after apply)
      + name             = "Trial-IntelXE-BE-Access-Policy"
      + priority         = 1
      + status           = "ACTIVE"
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

Plan: 2 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the the Access Polic for apps: Trial-IntelXE-BE-SBX (Preview)