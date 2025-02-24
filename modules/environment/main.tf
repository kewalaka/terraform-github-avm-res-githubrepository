
resource "github_repository_environment" "this" {

  repository  = var.repository.id
  environment = var.name

  wait_timer          = var.wait_timer
  can_admins_bypass   = var.can_admins_bypass
  prevent_self_review = var.prevent_self_review

  dynamic "reviewers" {
    for_each = var.reviewers
    content {
      users = reviewers.value.users
      teams = reviewers.value.teams
    }

  }

  deployment_branch_policy {
    protected_branches     = var.deployment_branch_policy.protected_branches
    custom_branch_policies = var.deployment_branch_policy.custom_branch_policies
  }

}

resource "github_repository_environment_deployment_policy" "this" {

  repository  = var.repository.id
  environment = var.name

  branch_pattern = var.deployment_policy_branch_pattern
  tag_pattern    = var.deployment_policy_tag_pattern

}
