output "group_ids" {
  value = { for env, group in okta_group.generated : env => group.id }
  description = "Map of environment to Okta group ID"
}

output "group_names" {
  value = { for env, group in okta_group.generated : env => group.name }
  description = "Map of environment to Okta group names"
}