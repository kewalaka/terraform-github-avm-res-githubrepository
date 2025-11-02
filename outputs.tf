output "admins" {
  description = "Teams with admin permissions to the repository."
  value       = github_team_repository.admin
}

output "branch_protection" {
  description = "Branch protection policies applied to the repository."
  value       = module.branch_protection_policies
}

output "branches" {
  description = "Branch configurations created by the branches module."
  value       = module.branches
}

output "maintainers" {
  description = "Teams with maintain permissions to the repository."
  value       = github_team_repository.maintain
}

output "pullers" {
  description = "Teams with read permissions (pull) to the repository."
  value       = github_team_repository.pull
}

output "pushers" {
  description = "Teams with write permissions (push) to the repository."
  value       = github_team_repository.push
}

output "repository" {
  description = "The GitHub repository resource created by this module."
  value       = github_repository.this
}

output "resource_id" {
  description = "The ID of the repository."
  value       = github_repository.this.id
}

output "rulesets" {
  description = "Rulesets applied to the repository."
  value       = module.rulesets
}
