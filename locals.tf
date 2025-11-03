locals {
  # Determine if branch protection can be enabled
  # Branch protection requires a repository node ID when targeting an existing repository.
  enable_branch_protection        = var.use_existing_repository ? var.repository_node_id != null : true
  enable_github_advanced_security = local.free_plan_visibility_notpublic ? false : var.github_advanced_security.enable_advanced_security || var.github_advanced_security.enable_secret_scanning || var.github_advanced_security.enable_secret_scanning_push_protection || var.visibility == "public"
  free_plan                       = data.github_organization.this.plan == "free"
  free_plan_visibility_notpublic  = local.free_plan && var.visibility != "public"
  has_wiki                        = local.free_plan_visibility_notpublic ? false : var.has_wiki
  repository_id                   = var.use_existing_repository ? var.name : github_repository.this[0].id
  # Repository identity - use existing repo name or created repo name
  repository_name    = var.use_existing_repository ? var.name : github_repository.this[0].name
  repository_node_id = var.use_existing_repository ? var.repository_node_id : github_repository.this[0].node_id
}
