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

// Global defaults: required (no defaults here)
// These are the values the *user* must supply when they create apps.
variable "default_label_basename" {
  description = "Base text used to build labels when an app label is not specified (e.g., 'TestSPA')."
  type        = string
}

variable "default_redirect_uris" {
  description = "Redirect URIs to use when an app does not specify them."
  type        = list(string)
}

variable "default_post_logout_uris" {
  description = "Post-logout URIs to use when an app does not specify them."
  type        = list(string)
}

// Per-app overrides: optional — user can pass nothing or only some fields
variable "spa_apps" {
  description = <<EOT
Map of apps to create. Each key is an environment or app name.
Omit fields to inherit the provided global defaults.
EOT
  type = map(object({
    label             = optional(string)
    redirect_uris     = optional(list(string))
    post_logout_uris  = optional(list(string))
  }))
}
variable "grant_types" {
  type    = list(string)
  default = ["authorization_code", "refresh_token"]
}

variable "type" {
  type    = string
  default = "browser"
  validation {
    condition     = var.type == "browser"
    error_message = "Web_app must use type = \"browser\"."
  }
}

variable "status" { 
  type = string  
  default = "ACTIVE" 
  }

variable "key_rotation" { 
  type = bool    
  default = true 
  }

# Response types are not used by client_credentials, but Okta accepts ["token"]
variable "response_types" {
  type    = list(string)
  default = ["code"]
}

variable "auth_method" {
  description = "Token endpoint auth for the web app"
  type        = string
  default     = "none" # or "private_key_jwt"
}
