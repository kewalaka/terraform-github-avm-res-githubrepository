module "branches" {
  source   = "./modules/branch"
  for_each = var.branches

  name = each.value.name
  repository = {
    id = local.repository_id
  }

  source_branch = try(each.value.source_branch, null)
  source_sha    = try(each.value.source_sha, null)
}

module "branch_protection_policies" {
  source   = "./modules/branch_protection"
  for_each = local.enable_branch_protection ? var.branch_protection_policies : {}

  repository = {
    id = local.repository_node_id
  }

  pattern                         = each.value.pattern
  enforce_admins                  = try(each.value.enforce_admins, null)
  require_conversation_resolution = try(each.value.require_conversation_resolution, null)
  required_linear_history         = try(each.value.required_linear_history, null)
  required_signed_commits         = try(each.value.require_signed_commits, null)
  force_push_bypassers            = try(each.value.force_push_bypassers, null)
  allows_deletions                = try(each.value.allows_deletions, null)
  allows_force_pushes             = try(each.value.allows_force_pushes, null)
  lock_branch                     = try(each.value.lock_branch, null)

  required_pull_request_reviews = try(each.value.required_pull_request_reviews, {})
  required_status_checks        = try(each.value.required_status_checks, {})
  restrict_pushes               = try(each.value.restrict_pushes, {})

  depends_on = [
    module.branches
  ]
}
