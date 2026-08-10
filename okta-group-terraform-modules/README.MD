This Okta Terraform module creates multiple groups in Okta in the form App-Test-App-SBX, App-Test-App-DEV, App-Test-App-TST, App-Test-App-UAT, App-Test-App-BTA (Preview Tenant) or App-Test-App-PRD, App-Test-App-TRN (Production Tenant)

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.OKTA_API_CLIENT_ID
   Enter a value: e.g. 0oaqlzaoegV62JGkm1d7 (Preview Tenant) 0oa1yp8nxg9ozMedX1d8 (Production Tenant)
2. Second input request: var.OKTA_API_TOKEN
   Enter a value: 
   The OKTA API Token will be provided as a secret to the user 
3. Third input request: var.OKTA_BASE_URL
   Enter a value: e.g. oktapreview.com (Preview Tenant) or okta.com (Production Tenant)
4. Fourth input request: var.OKTA_ORG_NAME
   Enter a value: e.g. wcgappsdev (Preview Tenant) or wcgapps (Production Tenant)
5. Fifth input request: var.default_basename
   Base text used to build labels for the associated app (e.g., if the associated app is 'TestSPA-PRD').
   Enter a value: e.g. TestSPA
6. Sixth input request: var.envs
   List of environments for which groups should be created
   Enter a value: e.g. ["SBX", "DEV", "TST", "UAT", "BTA"] (Preview Tenant) or ["TRN", "PRD"] (Production Tenant)

This will produce a plan for App-TestSPA-SBX, App-TestSPA-DEV, App-TestSPA-TST, App-TestSPA-UAT  and App-TestSPA-BTA (Preview Tenant):

Terraform used the selected providers to generate the
following execution plan. Resource actions are indicated
with the following symbols:
  + create

Terraform will perform the following actions:

  # module.my_okta_groups.okta_group.generated["BTA"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the BTA environment"
      + id          = (known after apply)
      + name        = "App-Test-App-BTA"
      + skip_users  = false
    }

  # module.my_okta_groups.okta_group.generated["DEV"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the DEV environment"
      + id          = (known after apply)
      + name        = "App-Test-App-DEV"
      + skip_users  = false
    }

  # module.my_okta_groups.okta_group.generated["SBX"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the SBX environment"
      + id          = (known after apply)
      + name        = "App-Test-App-SBX"
      + skip_users  = false
    }

  # module.my_okta_groups.okta_group.generated["TST"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the TST environment"
      + id          = (known after apply)
      + name        = "App-Test-App-TST"
      + skip_users  = false
    }

  # module.my_okta_groups.okta_group.generated["UAT"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the UAT environment"
      + id          = (known after apply)
      + name        = "App-Test-App-UAT"
      + skip_users  = false
    }

Plan: 5 to add, 0 to change, 0 to destroy.

─────

This will produce a plan for App-TestSPA-PRD and App-TestSPA-TRN (Production Tenant):

Terraform used the selected providers to generate the
following execution plan. Resource actions are indicated
with the following symbols:
  + create

Terraform will perform the following actions:

  # module.my_okta_groups.okta_group.generated["PRD"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the PRD environment"
      + id          = (known after apply)
      + name        = "App-Test-App-PRD"
      + skip_users  = false
    }

  # module.my_okta_groups.okta_group.generated["TRN"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the TRN environment"
      + id          = (known after apply)
      + name        = "App-Test-App-TRN"
      + skip_users  = false
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Terraform used the selected providers to
generate the following execution plan.
Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.my_okta_groups.okta_group.generated["PRD"] will be created
  + resource "okta_group" "generated" {
      + description = "Group for App in the PRD environment"
      + id          = (known after apply)
      + name        = "App-TestSPA-PRD"
      + skip_users  = false
    }

Plan: 1 to add, 0 to change, 0 to destroy.

# Run terraform apply
Provide values for the input requests similar to those provided when running terraform plan.

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the groups.

NB: The module can be adapted to create a single group as shown in the example folder that created the SBX or the PRD groups.