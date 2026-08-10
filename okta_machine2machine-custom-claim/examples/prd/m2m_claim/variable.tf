variable "org_name" {
  description = "okta org name."
  type        = string
}

variable "base_url" {
  description = "okta subdomain."
  type        = string
}
variable "default_basename" {
  description = "Base name used to compose env-specific labels (e.g., 'clinsphere_admin_m2m')."
  type        = string
}

variable "environments" {
  description = "List of environment codes to process (order preserved)."
  type        = list(string)
  //default     = ["SBX", "DEV", "TST", "UAT", "BTA"]
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


# If you want to pass a global list used by multiple claims
variable "existing_scopes" {
  type        = list(string)
  default     = []
  description = "List of existing scope names on the custom AS (used by claims if they don't specify their own scopes)."
}


# Toggle: should this module manage (create) the scopes? Default: No.
variable "manage_scopes" {
  type        = bool
  default     = false
  description = "If true, create/manage scopes in Okta. If false, assume scopes already exist."
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

variable "okta_api_token" {
  description = "Okta SSWS API token (needed when use_oauth_for_api=false)."
  type        = string
  sensitive   = true
  default     = null
}

variable "oauth_bearer_token" {
  description = "Bearer token for Okta Management APIs (when use_oauth_for_api=true)."
  type        = string
  sensitive   = true
  default     = null
}

variable "application_display_basename" {
  description = "Optional friendly display basename for the app 'label' field (e.g., 'ClinSphere-M2M'); '-<ENV>' is appended."
  type        = string
  default     = null
}

variable "custom_scopes" {
  type        = list(string)
  description = "List of scope names existing on the Custom AS (or to be created if manage_scopes=true)."
}

variable "claim_type" {
  type        = string
  description = "Claim type: \"RESOURCE\" (access token) or \"IDENTITY\" (ID token)."
  default     = "RESOURCE"
}

variable "claim_value_type" {
  type        = string
  description = "Value type: \"EXPRESSION\" or \"GROUPS\"."
  default     = "EXPRESSION"
}

variable "claim_value" {
  type        = string
  description = "Expression or groups value for the claim (e.g., \"app.profile.label\")."
  default     = "app.profile.label"
}

variable "always_include_claim" {
  type        = bool
  description = "If true, include the claim regardless of scopes."
  default     = false
}