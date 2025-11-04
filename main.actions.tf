# GitHub Actions Repository Permissions
resource "github_actions_repository_permissions" "this" {
  count = var.actions_repository_permissions.enabled != null ? 1 : 0

  repository      = local.repository_name
  enabled         = var.actions_repository_permissions.enabled
  allowed_actions = var.actions_repository_permissions.allowed_actions

  dynamic "allowed_actions_config" {
    for_each = var.actions_repository_permissions.allowed_actions == "selected" && var.actions_repository_permissions.allowed_actions_config != null ? [var.actions_repository_permissions.allowed_actions_config] : []
    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = allowed_actions_config.value.patterns_allowed
      verified_allowed     = allowed_actions_config.value.verified_allowed
    }
  }
}

# Runner Group Associations
# Only create associations when we have a valid repository_repo_id
module "actions_runner_groups" {
  source = "./modules/actions_runner_group"

  for_each = local.repository_repo_id != null ? var.actions_runner_groups : {}

  name                       = each.value.name
  repository                 = { id = local.repository_repo_id }
  visibility                 = each.value.visibility
  allows_public_repositories = each.value.allows_public_repositories
  restricted_to_workflows    = each.value.restricted_to_workflows
  selected_workflows         = each.value.selected_workflows
  existing_repository_ids    = each.value.existing_repository_ids
}
