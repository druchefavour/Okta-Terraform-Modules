
variable "okta_api_token" {
  type      = string
  sensitive = true
}

variable "default_basename" {
  description = "Base name used to compose env-specific labels (e.g., 'clinsphere_admin_m2m')."
  type        = string
}

variable "environments" {
  description = "List of environment codes to process (order preserved)."
  type        = list(string)
}

variable "org_name" {
  description = "okta org name."
  type        = string
}

variable "base_url" {
  description = "okta subdomain."
  type        = string
}

variable "apps_by_env" {
  description = <<EOT
Map of environment => client_id (Okta OIDC app). For OIDC apps, client_id == appId, so it can be used in /api/v1/apps/{clientId}.
Example:
{
  SBX = "0oa20iftaopJO8OhL1d8"
  DEV = "0oaxxxxxxxxDEVxxx"
  TST = "0oaxxxxxxxxTSTxxx"
}
EOT
  type = map(string)
}

variable "auth_server_id" {
  description = "Authorization server id (use 'default' or a custom AS ID)."
  type        = string
  default     = "default"
}

variable "custom_scopes" {
  description = "List of custom scopes to attach the claim to. They will be created if missing."
  type        = list(string)
}

variable "okta_domain" {
  description = "Your Okta org domain, e.g. 'your-org.okta.com' (no protocol)."
  type        = string
}

variable "use_oauth_for_api" {
  description = "If true, use an OAuth 2.0 bearer token in Authorization header. If false, use SSWS API token."
  type        = bool
  default     = false
}

variable "oauth_bearer_token" {
  description = "Bearer token for Okta Management APIs (when use_oauth_for_api=true)."
  type        = string
  sensitive   = true
  default     = null
}

variable "application_display_basename" {
  description = "Optional friendly display basename for the app 'label' field (e.g., 'Test-App'); '-<ENV>' is appended."
  type        = string
  default     = null
}

