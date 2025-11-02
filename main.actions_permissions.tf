module "actions_permissions" {
  source   = "./modules/actions_permissions"
  for_each = var.actions_permissions != null ? { "this" = var.actions_permissions } : {}

  repository = {
    id = github_repository.this.id
  }

  allowed_actions = try(each.value.allowed_actions, "all")
  enabled         = try(each.value.enabled, true)
  allowed_actions_config = try(each.value.allowed_actions_config, {
    github_owned_allowed = true
    patterns_allowed     = []
    verified_allowed     = false
  })
}
