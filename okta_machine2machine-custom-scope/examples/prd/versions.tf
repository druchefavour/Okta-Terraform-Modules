# versions.tf (example)
terraform {
  required_version = ">= 1.4"
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 6.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}
