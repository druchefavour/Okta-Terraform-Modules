# THis Okta Terraform Module creates an Okta custom claims related to applications in an environment a.g. SBX 

# Preview Tenant (https://wcgappsdev.oktapreview.com or https://preview.wcgclinical.com)
# (e.g., sbx). 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.apps_by_env
  Map of environment => client_id (Okta OIDC app). For OIDC apps, client_id == appId, so it can be used in /api/v1/apps/{clientId}.
  
  Example: For Apps AIMS -ECM-BE-SBX already created in Okta Preview Tenant
  # Preview
  { "SBX" = "0oam2r0bf0ZO7OOe41d7" }
   Enter a value: { "SBX" = "0oam2r0bf0ZO7OOe41d7" }
2. Second input request: var.base_url
   okta subdomain.
   Enter a value: e.g. oktapreview.com (Preview)
3. Third input request: var.custom_scopes
   List of custom scopes to attach the claim to. They will be created if missing.
   # Preview
   Enter a value: ["AIMS-ECM-BE-SBX-5a2dcb96-2bd1-4e41-acd7-25da6e66b6d0"]

4. Fourth input request: var.default_basename
   Base name used to compose env-specific labels (e.g., 'AIMS-ECM-BE').
   Enter a value: AIMS-ECM-BE
5. Fifth input request: var.environments
   List of environment codes to process (order preserved).
   # Preview
   Enter a value:["SBX"]
6. Sixth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:
7. Seventh input request: var.okta_domain
   Your Okta org domain, e.g. wcgappsdev.oktapreview.com (no protocol). 
8. Eight input request: var.org_name
   okta org name.
   Enter a value: wcgappsdev for the Preview Tenant 

# Preview Tenant (https://wcgappsdev.oktapreview.com and https://preview.wcgclinical.com)
Entering the SBX environment for the Preview Tenant produces a plan for  AIMS -ECM-BE-SBX:

Terraform used the selected providers to generate the
following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # module.app_claims.null_resource.update_app_profile["SBX"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oam2r0bf0ZO7OOe41d7"
          + "display_label"  = "AIMS-ECM-BE-TEST-SBX"
          + "payload_inputs" = "77a427e5d94f7d8d0978dda61e2c29319b5f8f02"
          + "profile_label"  = "App-AIMS-ECM-BE-TEST-SBX"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.okta_auth_server_claim.app_claim will be created
  + resource "okta_auth_server_claim" "app_claim" {
      + always_include_in_token = false
      + auth_server_id          = "default"
      + claim_type              = "RESOURCE"
      + id                      = (known after apply)
      + name                    = "App-AIMS-ECM-BE-TEST-Role"
      + scopes                  = [
          + "AIMS-ECM-BE-SBX-5a2dcb96-2bd1-4e41-acd7-25da6e66b6d0",
        ]
      + status                  = "ACTIVE"
      + value                   = "app.profile.label"
      + value_type              = "EXPRESSION"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────
# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" type "yes" to successfully create the claim for AIMS -ECM-BE-SBX
