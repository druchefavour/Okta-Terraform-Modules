output "scopes_by_env" {
  description = "Map of environment => { id, name } for the created scopes."
  value = {
    for env, res in okta_auth_server_scope.scopes :
    env => {
      id   = res.id
      name = res.name
    }
  }
}

output "scope_names" {
  description = "List of all created scope names."
  value       = [for s in okta_auth_server_scope.scopes : s.name]
}
