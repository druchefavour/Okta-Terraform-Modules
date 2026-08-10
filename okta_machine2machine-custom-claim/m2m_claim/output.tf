output "claim_name" {
  description = "The created claim name."
  value       = okta_auth_server_claim.app_claim
}

output "env_profile_labels" {
  description = "Map of env => computed app.profile.label value."
  value       = local.env_profile_label
}