This example creates a group in Okta in the form App-Test-App-PRD

# Ensure that the PRIVATE KEY is available as environmental variable.

e.g manual test (export TF_VAR_OKTA_API_PRIVATE_KEY="$(<pkcs1.pem)" ) if the PRIVATE KEY is pkcs1.pem and located in the root folder.

## Initialization

Run terraform init -upgrade

This will successfuly initialize the terraform module.

# Run terraform plan

1. First input request: var.OKTA_API_CLIENT_ID
   Enter a value: e.g. 0oa1yp8nxg9ozMedX1d8
2. Second input request: var.OKTA_API_TOKEN
   Enter a value: 
   The OKTA API Token will be provided as a secret to the user
3. Third input request: var.OKTA_BASE_URL
   Enter a value: e.g. okta.com
4. Fourth input request: var.OKTA_ORG_NAME
   Enter a value: e.g. wcgapps
5. Fifth input request: var.default_basename
   Base text used to build labels for the associated app (e.g., if the associated app is 'TestSPA-PRD').
   Enter a value: e.g. TestSPA
6. Sixth input request: var.envs
   List of environments for which groups should be created
   Enter a value: e.g. ["PRD"]
   
This will produce a plan for App-TestSPA-PRD:

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

Prompted to anmswer the question: "Do you want to perform these actions?" tpye "yes" to successfully create the app: App-TestSPA-PRD.
