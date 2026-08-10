
variable "okta_org_name"   { 
  type = string 
  }
variable "okta_base_url"   { 
    type = string 
    }
    
variable "okta_api_token"  { 
    type = string 
    sensitive = true 
    }
variable "label" {
  description = "Application label part of the scope name (e.g., 'Test_App')."
  type        = string
}

variable "envs" {
  description = "Environments for which to create scopes."
  type        = list(string)
}

variable "auth_server_id" {
  description = "Okta Authorization Server ID where scopes will be created."
  type        = string
}

variable "display_name" {
  description = "Optional human-friendly display name shown in consent dialogs. Defaults to the scope name."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional description for the scopes. Defaults to 'Custom scope for <label> in <ENV>'."
  type        = string
  default     = null
}

variable "consent" {
  description = "Whether consent dialog is needed for the scope: 'IMPLICIT' or 'REQUIRED'."
  type        = string
  default     = "IMPLICIT"
  validation {
    condition     = contains(["IMPLICIT", "REQUIRED"], var.consent)
    error_message = "consent must be 'IMPLICIT' or 'REQUIRED'."
  }
}

variable "metadata_publish" {
  description = "Whether to publish scope in metadata: 'ALL_CLIENTS' or 'NO_CLIENTS'."
  type        = string
  default     = "NO_CLIENTS"
  validation {
    condition     = contains(["ALL_CLIENTS", "NO_CLIENTS"], var.metadata_publish)
    error_message = "metadata_publish must be 'ALL_CLIENTS' or 'NO_CLIENTS'."
  }
}

variable "default_scope" {
  description = "If true, scope is returned when client omits 'scope' (subject to policy rules)."
  type        = bool
  default     = false
}
