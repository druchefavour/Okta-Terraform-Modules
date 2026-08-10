This example creates a single page app (spa) in Okta in the form Test-Web-SBX

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.OKTA_API_CLIENT_ID
   Enter a value: e.g. 0oaqlzaoegV62JGkm1d7
2. Second input request: var.OKTA_BASE_URL
   Enter a value: e.g. oktapreview.com
3. Third input request: var.OKTA_ORG_NAME
   Enter a value: e.g. wcgappsdev
4. Fourth input request: var.default_label_basename
   Base text used to build labels when an app label is not specified (e.g., 'TestSPA').
   Enter a value: e.g. TestSPA
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
   Enter a value: e.g. {"sbx" = {}} 

   This will produce a plan for Test-Web-SBX:


Terraform used the selected providers to generate the following
execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # module.spa.okta_app_oauth.spa_apps["sbx"] will be created
  + resource "okta_app_oauth" "spa_apps" {
      + accessibility_self_service = false
      + authentication_policy      = (known after apply)
      + auto_key_rotation          = true
      + auto_submit_toolbar        = false
      + client_id                  = (known after apply)
      + client_secret              = (sensitive value)
      + consent_method             = "TRUSTED"
      + grant_types                = [
          + "authorization_code",
          + "refresh_token",
        ]
      + hide_ios                   = true
      + hide_web                   = true
      + id                         = (known after apply)
      + issuer_mode                = "ORG_URL"
      + label                      = "TestSPA-SBX"
      + login_mode                 = "DISABLED"
      + logo_url                   = (known after apply)
      + name                       = (known after apply)
      + omit_secret                = false
      + pkce_required              = true
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
      + token_endpoint_auth_method = "none"
      + type                       = "browser"
      + user_name_template         = "${source.login}"
      + user_name_template_type    = "BUILT_IN"
      + wildcard_redirect          = "DISABLED"
    }

Plan: 1 to add, 0 to change, 0 to destroy.

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the app: Test-Web-SBX.
