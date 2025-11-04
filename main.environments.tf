module "environments" {
  source   = "./modules/environment"
  for_each = var.environments

  name = each.value.name
  repository = {
    id = local.repository_id
  }
  deployment_branch_policy = each.value.deployment_branch_policy != null ? {
    protected_branches     = each.value.deployment_branch_policy.protected_branches
    custom_branch_policies = each.value.deployment_branch_policy.custom_branch_policies
  } : null
  deployment_policy_branch_pattern = try(each.value.deployment_policy_branch_pattern, null)
  deployment_policy_tag_pattern    = try(each.value.deployment_policy_tag_pattern, null)
  reviewers = each.value.reviewers != null ? {
    users = each.value.reviewers.users
    teams = each.value.reviewers.teams
  } : null
}
