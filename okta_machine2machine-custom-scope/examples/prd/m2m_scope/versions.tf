terraform {
  required_version = ">= 1.4"
  required_providers {
    okta = {
      source  = "okta/okta"
      # Pin to a known-good version for reproducibility
      version = "~> 6.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}