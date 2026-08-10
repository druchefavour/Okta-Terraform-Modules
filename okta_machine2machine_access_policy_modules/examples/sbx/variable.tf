
variable "okta_api_token" {
  type      = string
  sensitive = true
}

variable "org_name" {
  description = "okta org name."
  type        = string
}

variable "base_url" {
  description = "okta subdomain."
  type        = string
}

variable "auth_server_id" {
  description = "Authorization server id (use 'default' or a custom AS ID)."
  type        = string
  default     = "default"
}

variable "default_basename" {
  description = "Base name used to build policy and rule names, and (by default) client labels."
  type        = string
}

variable "envs" {
  description = "Ordered list of environments to configure"
  type        = list(string)
  //default     = ["SBX", "DEV", "TST", "UAT", "BTA"]
}

variable "scopes_by_env" {
  description = <<EOT
Map of environment => list of existing scope names to allow.
Example:
{
  SBX = ["Trial-IntelXE-SBX-123..."]
  DEV = ["Trial-IntelXE-DEV-123..."]
  TST = ["Trial-IntelXE-TST-123..."]
}
EOT
  type = map(list(string))
}

# Option A (default): resolve client IDs by label. If you set this map, the module will look them up.
variable "client_labels_by_env" {
  description = "Map of environment => Okta OAuth app label. If empty, defaults to '<basename>-<ENV>'."
  type        = map(string)
}

variable "rule_priority_by_env" {
  description = "Optional override for per-environment rule priority."
  type        = map(number)
  default     = {}
}

variable "status" {
  description = "Policy and_rule status"
  type        = string
  default     = "ACTIVE"
  validation {
    condition     = contains(["ACTIVE", "INACTIVE"], var.status)
    error_message = "status must be ACTIVE or INACTIVE."
  }
}

variable "policy_priority" {
  description = "Overall policy priority relative to other policies on the same auth server."
  type        = number
  default     = 1
}

# --- Lifetimes (minutes) ---

# 1 hour
variable "access_token_lifetime_minutes" {
  description = "Access token lifetime in minutes"
  type        = number
  default     = 60
}

# 90 days
variable "refresh_token_lifetime_minutes" {
  description = "Absolute refresh token lifetime in minutes"
  type        = number
  default     = 129600
}

# 7 days (idle)
variable "refresh_token_idle_minutes" {
  description = "Refresh token idle timeout in minutes"
  type        = number
  default     = 10080
}

