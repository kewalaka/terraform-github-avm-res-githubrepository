resource "github_actions_variable" "this" {
  count         = local.variable_type == "repository" ? 1 : 0
  repository    = var.repository.id
  variable_name = var.name
  value         = var.value
}

resource "github_actions_environment_variable" "this" {
  count         = local.variable_type == "environment" ? 1 : 0
  repository    = var.repository.id
  variable_name = var.name
  value         = var.value
  environment   = var.environment
}
