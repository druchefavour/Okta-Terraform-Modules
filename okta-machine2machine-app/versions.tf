terraform {
      required_providers {
        random = {
          source = "hashicorp/random"
          version = "~> 3.0" # Use the appropriate version
        }
        okta = {
          source  = "okta/okta"
          version = "~> 4.6.0" # Specify your desired version
        }
      }
    }
