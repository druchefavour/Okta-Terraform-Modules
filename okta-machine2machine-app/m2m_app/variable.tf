
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

variable "grant_types" {
  type    = list(string)
  default = ["client_credentials"]
}

variable "type" {
  type    = string
  default = "service"
  validation {
    condition     = var.type == "service"
    error_message = "api_service_app must use type = \"service\"."
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
  default = ["token"]
}

variable "auth_method" {
  description = "Token endpoint auth for the service app"
  type        = string
  default     = "client_secret_post" # or "private_key_jwt"
}

/*variable "OKTA_API_TOKEN"       { 
    type = string  
    sensitive = true 
    }*/
variable "OKTA_ORG_NAME"        { type = string }
variable "OKTA_BASE_URL"        { 
    type = string  
   /* default = "oktapreview.com" /* Change to okta.com for prod*/
    }
variable "OKTA_API_CLIENT_ID"   { type = string }
variable "OKTA_API_PRIVATE_KEY" { 
    type = string  
    sensitive = true 
    }
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
