output "admins" {
  description = "Teams with admin permissions to the repository."
  value       = github_team_repository.admin
}

output "branch_protection" {
  description = "Branch protection policies applied to the repository."
  value       = module.branch_protection_policies
}

output "branch_protection_warning" {
  description = "Warning message if branch protection is skipped when using an existing repository without repository_node_id."
  value       = var.use_existing_repository && var.repository_node_id == null ? "Branch protection is skipped because repository_node_id was not provided. To enable branch protection, provide the repository node ID or use rulesets instead." : null
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
  description = "The GitHub repository resource created by this module. Null when use_existing_repository is true."
  value       = var.use_existing_repository ? null : github_repository.this[0]
}

output "repository_name" {
  description = "The name of the repository (either created or existing)."
  value       = local.repository_name
}

output "resource_id" {
  description = "The ID of the repository (name for existing repos, full ID for created repos)."
  value       = local.repository_id
}
