resource "okta_group" "generated" {
  for_each = toset(var.envs)

  name        = "${var.app}-${var.default_basename}-${each.value}"
  description = "Group for ${var.app} in the ${each.value} environment"
}
