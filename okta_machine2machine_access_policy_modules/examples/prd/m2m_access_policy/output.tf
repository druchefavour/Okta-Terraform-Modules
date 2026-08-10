#outputs.tf
output "policy_id" {
  description = "Created access policy ID"
  value       = okta_auth_server_policy.this.id
}

output "rule_ids_by_env" {
  description = "Map of environment => policy rule ID"
  value       = { for e, r in okta_auth_server_policy_rule.env_rules : e => r.id }
}
