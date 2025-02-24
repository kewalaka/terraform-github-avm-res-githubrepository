variable "environments" {
  type = map(object({
    name                = string
    wait_timer          = optional(number)
    can_admins_bypass   = optional(bool, true)
    prevent_self_review = optional(bool, true)
    reviewers = optional(object({
      users = optional(list(number))
      teams = optional(list(number))
    }))
    deployment_branch_policy = optional(object({
      protected_branches     = optional(bool)
      custom_branch_policies = optional(bool)
    }))
    deployment_policy_branch_pattern = optional(string)
    deployment_policy_tag_pattern    = optional(string)
  }))
  description = <<DESCRIPTION
Map of environments to be created along with their associated github action secrets and variables.

- name: Name of the environment
- reviewers: Up to 6 users and teams that are allowed to review deployments to this environment
- deployment_branch_policy: Object containing the deployment branch policy
  - protected_branches: Boolean indicating if the branch is protected
  - custom_branch_policies: Boolean indicating if custom branch policies are enabled
- deployment_policy_branch_pattern: Branch pattern for the deployment policy
- deployment_policy_tag_pattern: Tag pattern for the deployment policy

DESCRIPTION
  default     = {}
  validation {
    condition = alltrue([
      for environment in var.environments : (
        try(length(environment.reviewers.users) <= 6, true)
        &&
        try(length(environment.reviewers.teams) <= 6, true)
      )
    ])
    error_message = "Each environment may have up to 6 users and teams as reviewers."
  }
  nullable = false
}
