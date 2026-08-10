    terraform {
      required_providers {
        random = {
          source = "hashicorp/random"
          version = "~> 3.0" # Use the appropriate version
        }
        okta = {
          source  = "okta/okta"
          version = "~> 6.5.3" # Specify your desired version
        }
      }
    }