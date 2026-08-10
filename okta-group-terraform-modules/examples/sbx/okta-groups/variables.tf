variable "OKTA_API_TOKEN"       { 
    type = string  
    sensitive = true 
    }
variable "OKTA_ORG_NAME"        { 
  type = string 
  }
variable "OKTA_BASE_URL"        { 
    type = string  
    }
variable "OKTA_API_CLIENT_ID"   { 
  type = string 
  
  }
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

variable "envs" {
  type        = list(string)
  description = "List of environments for which groups should be created"
}

variable "app" {
  type        = string
  description = "Name of the application to prefix group names"
}

variable "default_basename" {
  type        = string
  description = "Default base name used in the group naming convention"
}
