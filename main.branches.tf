
resource "github_branch_protection" "this" {
  count                           = var.create_branch_policies ? 1 : 0
  repository_id                   = github_repository.this.name
  pattern                         = "main"
  enforce_admins                  = true
  required_linear_history         = true
  require_conversation_resolution = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    restrict_dismissals             = true
    required_approving_review_count = length(var.approvers) > 1 ? 1 : 0
  }

  #depends_on = [github_repository_file.alz]
}
