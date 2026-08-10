# Generate a GUID per environment
resource "random_uuid" "scope_guid" {
  for_each = toset(var.envs)
}

locals {
  # Build the final scope name: <Label>-<ENV>-<GUID>
  # You can tweak case handling of label if you need (left as-is here).
  scope_names = {
    for env, u in random_uuid.scope_guid :
    env => "${var.label}-${upper(env)}-${u.result}"
  }
}

