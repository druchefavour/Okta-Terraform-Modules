This example creates multiple web apps in Okta. It can also be adapted to create one application as demonstrated by the examples in the example folder. But here we will demonstrate creating apps in multiple Preview environments. 

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.OKTA_API_CLIENT_ID
   Enter a value: e.g. 0oaqlzaoegV62JGkm1d7 (Preview) 0oa1yp8nxg9ozMedX1d8(Production)
2. Second input request: var.OKTA_BASE_URL
   Enter a value: e.g. oktapreview.com (Preview) okta.com (Production)
3. Third input request: var.OKTA_ORG_NAME
   Enter a value: e.g. wcgappsdev (Preview) wcgapps (Production)
4. Fourth input request: var.default_label_basename
   Base text used to build labels when an app label is not specified (e.g., 'Test-Web').
   Enter a value: e.g. Test-Web
5. Fifth input request
   var.default_post_logout_uris
   Post-logout URIs to use when an app does not specify them.
   Enter a value: ["http://localhost:5000/logout", "http://localhost:5001/logout"] 
6. Sixth input request
   var.default_redirect_uris
   Redirect URIs to use when an app does not specify them.
   Enter a value: ["http://localhost:5000/callback", "http://localhost:5001/callback"]
5. Seventh input request: var.web_apps
   Map of apps to create. Each key is an environment or app name.
   Omit fields to inherit the provided global defaults.
   Enter a value: e.g. {"sbx" = {}, "dev" = {}, "tst" = {}, "uat" = {}, "bta" = {}} (Preview) {"prd" = {}, "trn" = {}} (Production) 

# Preview Tenant (https://wcgapps.okta.com and https://preview.wcgclinical.com)
Entering the multiple environments for the Preview Tenant produces a plan for Test-Web-SBX, Test-Web-DEV, Test-Web-TST, Test-Web-UAT, Test-Web-BTA:

    
Terraform used the selected providers
to generate the following execution
plan. Resource actions are indicated
with the following symbols:
  + create

Terraform will perform the following actions:

  # module.web.okta_app_oauth.web_apps["bta"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-BTA"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

  # module.web.okta_app_oauth.web_apps["dev"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-DEV"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

  # module.web.okta_app_oauth.web_apps["sbx"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-SBX"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

  # module.web.okta_app_oauth.web_apps["tst"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-TST"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

  # module.web.okta_app_oauth.web_apps["uat"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-UAT"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

Plan: 5 to add, 0 to change, 0 to destroy.

# Production Tenant (https://wcgapps.okta.com or https://login.wcgclinical.com)
Entering the multiple environments for the Production Tenant produces a plan for Test-Web-PRD, Test-Web-TRN:

Terraform used the selected providers to generate the
following execution plan. Resource actions are indicated
with the following symbols:
  + create

Terraform will perform the following actions:

  # module.web.okta_app_oauth.web_apps["prd"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-PRD"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

  # module.web.okta_app_oauth.web_apps["trn"] will be created
  + resource "okta_app_oauth" "web_apps" {
      + accessibility_self_service = false
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "Test-Web-TRN"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + post_logout_redirect_uris  = [
          + "http://localhost:5000/logout",
          + "http://localhost:5001/logout",
        ]
      + redirect_uris              = [
          + "http://localhost:5000/callback",
          + "http://localhost:5001/callback",
        ]
      + refresh_token_leeway       = 0
      + refresh_token_rotation     = "STATIC"
      + response_types             = [
          + "code",
        ]
      + sign_on_mode               = (known after apply)
      + status                     = "ACTIVE"
      + token_endpoint_auth_method = "client_secret_post"
      + type                       = "web"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

Plan: 2 to add, 0 to change, 0 to destroy.

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the apps: Test-Web-SBX, Test-Web-DEV, Test-Web-TST, Test-Web-UAT, Test-Web-BTA (Preview) and Test-Web-PRD, Test-Web-TRN (Production)
