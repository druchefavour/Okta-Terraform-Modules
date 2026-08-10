// Global defaults: required (no defaults here)
// These are the values the *user* must supply when they create apps.
variable "default_label_basename" {
  description = "Base text used to build labels when an app label is not specified (e.g., 'Test-M2M-BE')."
  type        = string
}

// Per-app overrides: optional — user can pass nothing or only some fields
variable "m2m_apps" {
  description = <<EOT
Map of apps to create. Each key is an environment or app name.
Omit fields to inherit the provided global defaults.
EOT
  type = map(object({
    label             = optional(string)
  }))
}

# Defines the app type. For M2M, we are creating a service app.
variable "type" {
  type    = string
  default = "service"
  validation {
    condition     = var.type == "service"
    error_message = "api_service_app must use type = \"service\"."
  }
}

# Defines the grant type. For M2M, we are using client credentials.
variable "grant_types" {
  type    = list(string)
  default = ["client_credentials"]
}

# Defines the authentication method. For WCG M2M, we are using client secret.
variable "auth_method" {
  description = "Token endpoint auth for the service app"
  type        = string
  default     = "client_secret_post" # or "private_key_jwt"
}

# Explains whether key rotation is needed.
variable "key_rotation" { 
  type = bool    
  default = true 
  }

# Explains whether created apps should be active or inactive.
  variable "status" { 
  type = string  
  default = "ACTIVE" 
  }

# OKTA_ORG_NAME represents the name of the Okta Org (wcgappsdev for the preview tenant housing SBX). 
# User input

variable "OKTA_ORG_NAME"        { 
    type = string 
}

# OKTA_BASE_URL represents the name of the Okta domain (oktapreview.com for the preview tenant housing SBX). 
# User input

variable "OKTA_BASE_URL"        { 
    type = string  
    }

# OKTA_API_CLIENT_ID represents the App ID (Client ID) of the API service app created for to manage the Terraform 
# module for the preview tenant housing SBX). Provided privately to user
# User input

variable "OKTA_API_CLIENT_ID"   { 
    type = string 
    }

# OKTA_API_PRIVATE_KEY represents the private key for authentication. It is associated with the Terrform API service app created for to manage the Terraform 
# module for the preview tenant housing SBX). Provided privately to user 
# User input

variable "OKTA_API_PRIVATE_KEY" { 
    type = string  
    sensitive = true 
    }

# OKTA_API_SCOPES represent the Okta Scopes associated with the Terraform API service app created for to manage the Terraform 
# module for the preview tenant housing SBX). Provided privately to user
# default already provided

variable "OKTA_API_SCOPES"      { 
    type = list(string) 
    default = [
        "okta.groups.manage", 
        "okta.apps.manage", 
        "okta.apps.read", 
        "okta.policies.manage",
        "okta.authenticators.manage",
        "okta.authorizationServers.manage"
        ]
    }