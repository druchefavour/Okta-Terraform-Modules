Create an Okta Terraform module that generates access polocy.
1. Authorization Server ID: default
2. Access Policy Name: default_basename-Access-Policy (default_basename to be provided user e.g. Trial-IntelXE-BE)
3. Description: Access Policy for default_basename applications
3. Assign: The following Clients
4. Clients are in different environments (sbx, dev, tst, uat and bta) the form: default_basename-SBX, default_basename-DEV, default_basename-TST etc 
5. Create Access Policy Rules for the different environments and clients, Rule Name: default_basename-<env>-Access-Rule (e.g default_basename-SBX-Access-Rule, default_basename-DEV-Access-Rule, etc)
6. Grant type is: Client Credentials
7. User is: default
8. Scopes requested: The following scopes (Assign custom scopes already created and existing in Okta, e.g ["Trial-IntelXE-SBX-1233333333..."], ["Trial-IntelXE-DEV-1233333333..."], ["Trial-IntelXE-TST-1233333333..."] etc)
9. Use this inline hook: None
10. Access token lifetime is: 1 hour
11. Refresh token lifetime is: 90 days
12. but will expire if not used every: 7  days

Awesome—here’s a self-contained Terraform module that will create an Okta Authorization Server Access Policy and one policy rule per environment for Client Credentials—naming everything from your default_basename, assigning specific clients per environment, and wiring the lifetimes you specified.
✅ Defaults baked inAuth Server ID = defaultPolicy name = <basename>-Access-PolicyRule name(s) = <basename>-<ENV>-Access-Rule (e.g., Trial-IntelXE-BE-SBX-Access-Rule)Grant type = client_credentialsAccess token lifetime = 1 hour (60 minutes)Refresh token lifetime = 90 days (129,600 minutes)Refresh token expires if idle = 7 days (10,080 minutes)Inline hook = noneUser condition = default (not set; not applicable for client credentials)
ℹ️ Note on refresh tokens & client credentials
Okta does not issue refresh tokens for the Client Credentials flow. We still configure refresh lifetimes per your request; Okta will ignore them for CC, but the settings won’t break anything and are useful if you later enable additional grants on the same rules/policy.
￼
1) Module structure
modules/
└── okta-access-policy/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf

main.tf
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 4.9.0"
    }
  }
}

locals {
  # If explicit client labels are not provided, derive labels as "<basename>-<ENV>"
  derived_client_labels_by_env = {
    for e in var.envs : e => "${var.default_basename}-${e}"
  }

  effective_client_labels_by_env = length(var.client_labels_by_env) > 0
    ? var.client_labels_by_env
    : local.derived_client_labels_by_env
}

# Option A: resolve OAuth client IDs by label (recommended)
# (One lookup per environment)
data "okta_app_oauth" "clients" {
  for_each = toset(var.envs)
  label    = local.effective_client_labels_by_env[each.key]
}

# Prepare a map of client_ids by env:
# If user provides client_ids_by_env explicitly, prefer them.
# Otherwise, use the IDs discovered by label lookups above.
locals {
  effective_client_ids_by_env = length(var.client_ids_by_env) > 0
    ? var.client_ids_by_env
    : { for e in var.envs : e => data.okta_app_oauth.clients[e].client_id }
}

# --- Policy ---

resource "okta_auth_server_policy" "this" {
  auth_server_id = var.auth_server_id
  name           = "${var.default_basename}-Access-Policy"
  description    = "Access Policy for ${var.default_basename} applications"
  priority       = var.policy_priority
  status         = var.status
}

# --- One rule per environment ---

resource "okta_auth_server_policy_rule" "env_rules" {
  for_each = toset(var.envs)

  auth_server_id = var.auth_server_id
  policy_id      = okta_auth_server_policy.this.id
  name           = "${var.default_basename}-${each.key}-Access-Rule"

  # Let earlier envs in var.envs have higher priority by default; can override via var.rule_priority_by_env
  priority = lookup(var.rule_priority_by_env, each.key, 10 + index(var.envs, each.key))

  status = var.status

  # Assign to the single client for this environment
  client_whitelist = [local.effective_client_ids_by_env[each.key]]

  # Grant type: Client Credentials only
  grant_type_whitelist = ["client_credentials"]

  # Scopes that must already exist in the auth server
  scope_whitelist = lookup(var.scopes_by_env, each.key, [])

  # Inline hook intentionally omitted (None)

  # Lifetimes (minutes)
  access_token_lifetime_minutes   = var.access_token_lifetime_minutes
  refresh_token_lifetime_minutes  = var.refresh_token_lifetime_minutes
  refresh_token_idle_minutes      = var.refresh_token_idle_minutes
}

variables.tf
variable "auth_server_id" {
  description = "Authorization Server ID (e.g., 'default')"
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
  default     = ["SBX", "DEV", "TST", "UAT", "BTA"]
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
  default     = {}
}

# Option B: pass client IDs directly. If set, this takes precedence over label lookup.
variable "client_ids_by_env" {
  description = "Map of environment => Okta OAuth client_id. Overrides label-based lookup when provided."
  type        = map(string)
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

variable "rule_priority_by_env" {
  description = "Optional override for per-environment rule priority."
  type        = map(number)
  default     = {}
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

outputs.tf
output "policy_id" {
  description = "Created access policy ID"
  value       = okta_auth_server_policy.this.id
}

output "rule_ids_by_env" {
  description = "Map of environment => policy rule ID"
  value       = { for e, r in okta_auth_server_policy_rule.env_rules : e => r.id }
}

output "client_ids_by_env" {
  description = "Effective client IDs used for each environment"
  value       = local.effective_client_ids_by_env
}

￼
2) Example usage (root module)
The provider configuration belongs in the root (your stack), not inside the module.
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    okta = {
      source  = "okta/okta"
      version = ">= 4.9.0"
    }
  }
}

provider "okta" {
  org_name  = var.okta_org_name      # e.g., "mycompany"
  base_url  = var.okta_base_url      # e.g., "okta.com" or "okta-emea.com"
  api_token = var.okta_api_token
}

# --- Example variables you may keep in *.tfvars or a workspace ---

variable "okta_org_name"   { type = string }
variable "okta_base_url"   { type = string }
variable "okta_api_token"  { type = string, sensitive = true }

module "intelxe_be_access_policy" {
  source = "./modules/okta-access-policy"

  default_basename = "Trial-IntelXE-BE"
  auth_server_id   = "default"

  # Environments to manage
  envs = ["SBX", "DEV", "TST", "UAT", "BTA"]

  # Option A: let the module find clients by label "<basename>-<ENV>" (no extra inputs needed)
  # Optionally override labels explicitly:
  client_labels_by_env = {
    SBX = "Trial-IntelXE-BE-SBX"
    DEV = "Trial-IntelXE-BE-DEV"
    TST = "Trial-IntelXE-BE-TST"
    UAT = "Trial-IntelXE-BE-UAT"
    BTA = "Trial-IntelXE-BE-BTA"
  }

  # Option B: supply client IDs directly (takes precedence if provided)
  # client_ids_by_env = {
  #   SBX = "0oa1abcdeSBX"
  #   DEV = "0oa1abcdeDEV"
  #   TST = "0oa1abcdeTST"
  #   UAT = "0oa1abcdeUAT"
  #   BTA = "0oa1abcdeBTA"
  # }

  # Scopes must already exist in the 'default' auth server
  scopes_by_env = {
    SBX = ["Trial-IntelXE-SBX-1233333333"]
    DEV = ["Trial-IntelXE-DEV-1233333333"]
    TST = ["Trial-IntelXE-TST-1233333333"]
    UAT = ["Trial-IntelXE-UAT-1233333333"]
    BTA = ["Trial-IntelXE-BTA-1233333333"]
  }

  # Lifetimes (minutes): defaults already set to 60 / 129600 / 10080
  # access_token_lifetime_minutes  = 60
  # refresh_token_lifetime_minutes = 129600
  # refresh_token_idle_minutes     = 10080
}

￼
3) Why these exact minute values?
I computed the lifetimes to minutes so Terraform receives canonical numeric inputs:
• 1 hour = 60 minutes
• 90 days = 129,600 minutes
• 7 days = 10,080 minutes
(Computed programmatically to avoid off‑by‑one mistakes.)
￼
4) Operational notes & guardrails
• Scopes must pre-exist in the Authorization Server named by auth_server_id (default is the system “default” AS). If they don’t, either create them manually or wire a separate okta_auth_server_scope workflow (your request said “already created and existing,” so this module only assigns them).
• Client resolution: By default, the module resolves each environment’s client by label <basename>-<ENV>. If your labels differ, set client_labels_by_env; if you already have client IDs, prefer client_ids_by_env for determinism.
• Rule priority: Defaults to 10 + index(env) to give predictable stacking; override any environment’s priority with rule_priority_by_env.
• User condition: Not set (default behavior). That’s intentional for client_credentials; there is no end-user context.
• Inline hooks: omitted (None as requested). If you later want a Token Inline Hook, you can add the inline_hook_id attribute to each rule.
￼
5) Quick checklist before terraform apply
1. Okta provider is authenticated (API token) and points at the correct org/base URL.
2. The clients (OAuth apps) exist—either with labels matching <basename>-<ENV> or you supplied client_ids_by_env.
3. The scopes exist in the default authorization server (exact names).
4. You’re comfortable with the policy and rule priorities relative to other policies in that auth server.
￼
6) Want me to wire this to your concrete example?
If you share:
• default_basename (e.g., Trial-IntelXE-BE),
• the exact scope names per environment, and
• either the client labels or the client IDs,
I can drop in a ready-to-run examples/ folder for you, including *.tfvars and a one-liner make plan/apply wrapper.
￼
Computed lifetimes (minutes) used above: access=60, refresh=129600, idle=10080.