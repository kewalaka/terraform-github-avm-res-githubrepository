resource "github_actions_repository_permissions" "this" {
  repository = var.repository.id

  allowed_actions = var.allowed_actions
  enabled         = var.enabled

  dynamic "allowed_actions_config" {
    for_each = var.allowed_actions == "selected" ? [1] : []
    content {
      github_owned_allowed = var.allowed_actions_config.github_owned_allowed
      patterns_allowed     = var.allowed_actions_config.patterns_allowed
      verified_allowed     = var.allowed_actions_config.verified_allowed
    }
  }
}
