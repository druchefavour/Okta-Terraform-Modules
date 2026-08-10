# THis Okta Terraform Module creates an  Okta custom claims related to applications in multiple environments 

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

1. First input request: var.apps_by_env
  Map of environment => client_id (Okta OIDC app). For OIDC apps, client_id == appId, so it can be used in /api/v1/apps/{clientId}.
  
  Example: For Apps AIMS -ECM-BE-SBX, AIMS -ECM-BE-DEV, AIMS -ECM-BE-TST, AIMS -ECM-BE-UAT and AIMS -ECM-BE-BTA already created in Okta Preview Tenant
  # Preview
  {
    "SBX" = "0oam2r0bf0ZO7OOe41d7",
    "DEV" = " 0oamxoupt8DacnC3t1d7",
    "TST" = "0oamxp1rogLCq6zgc1d7",
    "UAT" = "0oamxp54npEutJUUx1d7",
    "BTA" = "0oamxp4jq2UDbaeR11d7"
  }
   Enter a value: {    "SBX" = "0oam2r0bf0ZO7OOe41d7",    "DEV" = " 0oamxoupt8DacnC3t1d7",    "TST" = "0oamxp1rogLCq6zgc1d7",    "UAT" = "0oamxp54npEutJUUx1d7",    "BTA" = "0oamxp4jq2UDbaeR11d7"  }
 
 # Production 
 {
    "PRD" = "0oa1wc8l0vfKrhPJj1d8",
    "TRN" = "0oa1wc8jf6vZjSIOR1d8"
  }
Enter a value: {    "PRD" = "0oa1wc8l0vfKrhPJj1d8",    "TRN" = "0oa1wc8jf6vZjSIOR1d8"  }
2. Second input request: var.base_url
   okta subdomain.
   Enter a value: e.g. oktapreview.com (Preview) okta.com (Production)
3. Third input request: var.custom_scopes
   List of custom scopes to attach the claim to. They will be created if missing.
   # Preview
   Enter a value: ["AIMS-ECM-BE-SBX-5a2dcb96-2bd1-4e41-acd7-25da6e66b6d0", "AIMS-ECM-BE-DEV-a34e7228-af70-44ea-b51d-176374deb609", "AIMS-ECM-BE-TST-60faba9a-3e65-4aa8-9cb3-d9db15d377df", "AIMS-ECM-BE-UAT-97806e1f-9a9a-419c-9f06-06c25813a411", "AIMS-ECM-BE-BTA-0ee55387-9d91-4229-9888-600f65e17947"]
   or
   # Production
   Enter a value: ["AIMS-ECM-BE-PRD-54319db1-293e-4243-a89f-3a92cd832130", "AIMS-ECM-BE-TRN-6bbf56bb-e173-4a90-9abd-fcac3288eaac"]
4. Fourth input request: var.default_basename
   Base name used to compose env-specific labels (e.g., 'AIMS-ECM-BE').
   Enter a value: AIMS-ECM-BE
5. Fifth input request: var.environments
   List of environment codes to process (order preserved).
   # Preview
   Enter a value:["SBX", "DEV", "TST", "UAT", "BTA"]

   # Production
   Enter a value: ["PRD", "TRN"]
6. Sixth input request: var.okta_api_token
   Token to be provided to the user # Sensitive
   Enter a value:
7. Seventh input request: var.okta_domain
   Your Okta org domain, e.g. wcgappsdev.oktapreview.com or wcgapps.okta.com (no protocol). 
8. Eight input request: var.org_name
   okta org name.
   Enter a value: wcgappsdev for the Preview Tenant or wcgapps for the Production Tenant 

# Preview Tenant (https://wcgapps.okta.com and https://preview.wcgclinical.com)
Entering the multiple environments for the Preview Tenant produces a plan for  AIMS -ECM-BE-SBX, AIMS -ECM-BE-DEV, AIMS -ECM-BE-TST, AIMS -ECM-BE-UAT and AIMS -ECM-BE-BTA:

Terraform used the selected providers to generate the
following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # module.app_claims.null_resource.update_app_profile["BTA"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oamxp4jq2UDbaeR11d7"
          + "display_label"  = "AIMS-ECM-BE-BTA"
          + "payload_inputs" = "d80ffd81d7557c353c5667ef4cd6531a78ba3c6a"
          + "profile_label"  = "App-AIMS-ECM-BE-BTA"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.null_resource.update_app_profile["DEV"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = " 0oamxoupt8DacnC3t1d7"
          + "display_label"  = "AIMS-ECM-BE-DEV"
          + "payload_inputs" = "5dbe731b7ce13f3e8b257bb3f5def4a2a156f660"
          + "profile_label"  = "App-AIMS-ECM-BE-DEV"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.null_resource.update_app_profile["SBX"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oam2r0bf0ZO7OOe41d7"
          + "display_label"  = "AIMS-ECM-BE-SBX"
          + "payload_inputs" = "1dc88d366c2f608389a26437d08d79ec875e1f31"
          + "profile_label"  = "App-AIMS-ECM-BE-SBX"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.null_resource.update_app_profile["TST"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oamxp1rogLCq6zgc1d7"
          + "display_label"  = "AIMS-ECM-BE-TST"
          + "payload_inputs" = "222fe7e8cbbdcce3c242dd9034c6de6b122ca7ed"
          + "profile_label"  = "App-AIMS-ECM-BE-TST"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.null_resource.update_app_profile["UAT"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oamxp54npEutJUUx1d7"
          + "display_label"  = "AIMS-ECM-BE-UAT"
          + "payload_inputs" = "f26a93370c512f6a864a49845da76443eda062be"
          + "profile_label"  = "App-AIMS-ECM-BE-UAT"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.okta_auth_server_claim.app_claim will be created
  + resource "okta_auth_server_claim" "app_claim" {
      + always_include_in_token = false
      + auth_server_id          = "default"
      + claim_type              = "RESOURCE"
      + id                      = (known after apply)
      + name                    = "App-AIMS-ECM-BE-Role"
      + scopes                  = [
          + "AIMS-ECM-BE-BTA-0ee55387-9d91-4229-9888-600f65e17947",
          + "AIMS-ECM-BE-DEV-a34e7228-af70-44ea-b51d-176374deb609",
          + "AIMS-ECM-BE-SBX-5a2dcb96-2bd1-4e41-acd7-25da6e66b6d0",
          + "AIMS-ECM-BE-TST-60faba9a-3e65-4aa8-9cb3-d9db15d377df",
          + "AIMS-ECM-BE-UAT-97806e1f-9a9a-419c-9f06-06c25813a411",
        ]
      + status                  = "ACTIVE"
      + value                   = "app.profile.label"
      + value_type              = "EXPRESSION"
    }

Plan: 6 to add, 0 to change, 0 to destroy.

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
Entering the multiple environments for the Production Tenant produces a plan for AIMS-ECM-BE-PRD, AIM-ECM-BE-TRN:

TTerraform used the selected providers to generate the
following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # module.app_claims.null_resource.update_app_profile["PRD"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oa1wc8l0vfKrhPJj1d8"
          + "display_label"  = "AIMS-ECM-BE-PRD"
          + "payload_inputs" = "31ad62e8fa1bf626778a61ee4e32c78ad50a931a"
          + "profile_label"  = "App-AIMS-ECM-BE-PRD"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

  # module.app_claims.null_resource.update_app_profile["TRN"] will be created
  + resource "null_resource" "update_app_profile" {
      + id       = (known after apply)
      + triggers = {
          + "client_id"      = "0oa1wc8jf6vZjSIOR1d8"
          + "display_label"  = "AIMS-ECM-BE-TRN"
          + "payload_inputs" = "8aba8f9510ca35e621ed4341627c8e0eac587832"
          + "profile_label"  = "App-AIMS-ECM-BE-TRN"
          + "template_sha1"  = "8d4ff9bd5c83f0801e4dfa408b01eb5e614d5ca3"
        }
    }

 # module.app_claims.okta_auth_server_claim.app_claim will be created
  + resource "okta_auth_server_claim" "app_claim" {
      + always_include_in_token = false
      + auth_server_id          = "default"
      + claim_type              = "RESOURCE"
      + id                      = (known after apply)
      + name                    = "App-AIMS-ECM-BE-Role"
      + scopes                  = [
          + "AIMS-ECM-BE-PRD-54319db1-293e-4243-a89f-3a92cd832130",
          + "AIMS-ECM-BE-TRN-6bbf56bb-e173-4a90-9abd-fcac3288eaac",
        ]
      + status                  = "ACTIVE"
      + value                   = "app.profile.label"
      + value_type              = "EXPRESSION"
    }

Plan: 3 to add, 0 to change, 5 to destroy.

────────

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the claims for apps: AIMS -ECM-BE-SBX, AIMS -ECM-BE-DEV, AIMS -ECM-BE-TST, AIMS -ECM-BE-UAT and AIMS -ECM-BE-BTA (Preview) and AIMS -ECM-BE-PRD, AIMS -ECM-BE-TRN (Production)

# OPERATION DETAIL
Use the Client ID of each app to run an Okta profile update api to generate app.profile.label.
Use this as the body for the profile update api:
{
    "name": "oidc_client",
    "label": e.g. "ClinSphere-M2M-PRD",
    "signOnMode": "OPENID_CONNECT",
    "credentials": {
        "oauthClient": {
            "autoKeyRotation": true,
            "client_id": e.g "0oa20iftaopJO8OhL1d8",
            "token_endpoint_auth_method": "client_secret_basic"
        }
    },
    "profile": {
        "label": e.g. "clinsphere_admin_m2m_prd"
    },

    "settings": {
        "oauthClient": {
            "client_uri": null,
            "logo_uri": null,
            "redirect_uris": [],
            "response_types": [
                "token"
            ],
            "grant_types": [
                "client_credentials"
            ],
            "application_type": "service",
            "consent_method": "REQUIRED",
            "issuer_mode": "DYNAMIC",
            "idp_initiated_login": {
                "mode": "DISABLED",
                "default_scope": []
            },
            "wildcard_redirect": "DISABLED"
        }
    }
}

For "profile": {
        "label": e.g. "clinsphere_admin_m2m_prd"
    },
    the label for each environment should be default-basename-<env>, forinstance, default-basename-SBX, default-basename-DEV, default-basename-TST etc. "default-basename" is a variable to be selected by the user. For the Custom claim, the name should be in the format default-basename-Role and the value should be the app.profile.label generated via the PUT request for the profile update api. A list of scopes shall be assigned to the claims depending on the number of environments created. The list of custon scopes is an input by the user. The expectation is that when I want to generate claim for application TestM2M-SBX it will be in the format default-basename-Role: default-basename-SBX, for TestM2M-DEV and default-basename-Role: default-basename-DEV etc

__________________________________________________________________
Reusable Terraform module that:

updates each OIDC service app’s app.profile.label via the Okta Apps API (using the app’s Client ID), and
creates a single custom claim named "<default-basename>-Role" whose value is the app.profile.label, tied to a caller‑provided list of custom scopes.

This yields tokens like:

For TestM2M-SBX → default-basename-Role: default-basename-SBX
For TestM2M-DEV → default-basename-Role: default-basename-DEV
…and so on (per environment).

Why this works (quick context)

For Okta OIDC/OAuth apps, the client_id is the app ID. That means you can call PUT /api/v1/apps/{clientId} to update the app—including its profile object. [developer.okta.com]
To emit application metadata in tokens, Okta supports reading from the app profile with the expression app.profile.* in custom claims. We’ll set profile.label to the environment-specific value and reference it in a claim. [support.okta.com], [support.okta.com]
In Terraform, the okta_auth_server_claim resource lets us define a claim, set value_type = "EXPRESSION", value = "app.profile.label", and attach a list of scopes. [registry.t...rraform.io]


Security note (recommended auth): For automation, Okta recommends using an OAuth 2.0 service app (Client Credentials) with granular Okta scopes (e.g., okta.apps.manage) instead of long‑lived SSWS tokens. The Okta “OAuth for Okta” and Terraform access design guides outline this model. (This module supports both; see “Provider + auth options”.) [developer.okta.com], [developer.okta.com]

Module layout
okta-app-claims-by-env/
├─ main.tf
├─ variables.tf
├─ outputs.tf
└─ templates/
   └─ update_app_payload.json.tmpl