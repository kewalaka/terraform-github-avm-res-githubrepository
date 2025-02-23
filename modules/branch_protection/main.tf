resource "github_branch_protection" "this" {
  repository_id                   = var.repository.id
  pattern                         = var.pattern
  enforce_admins                  = var.enforce_admins
  require_conversation_resolution = var.require_conversation_resolution
  required_linear_history         = var.required_linear_history
  require_signed_commits          = var.required_signed_commits
  force_push_bypassers            = var.force_push_bypassers
  allows_deletions                = var.allows_deletions
  allows_force_pushes             = var.allows_force_pushes
  lock_branch                     = var.lock_branch

  dynamic "required_pull_request_reviews" {
    for_each = var.required_pull_request_reviews != {} ? [var.required_pull_request_reviews] : []
    content {
      dismiss_stale_reviews           = try(required_pull_request_reviews.value.dismiss_stale_reviews, null)
      require_code_owner_reviews      = try(required_pull_request_reviews.value.require_code_owner_reviews, null)
      required_approving_review_count = try(required_pull_request_reviews.value.required_approving_review_count, null)
    }
  }

  dynamic "required_status_checks" {
    for_each = var.required_status_checks != {} ? [var.required_status_checks] : []
    content {
      strict   = try(required_status_checks.value.strict, null)
      contexts = try(required_status_checks.value.contexts, null)
    }
  }

  dynamic "restrict_pushes" {
    for_each = var.restrict_pushes != {} ? [var.restrict_pushes] : []
    content {
      blocks_creations = try(restrict_pushes.value.blocks_creations, null)
      push_allowances  = try(restrict_pushes.value.push_allowances, null)
    }
  }
}
