output "repository_name" {
  description = "Name of the created repository"
  value       = module.github_repository.repository_name
}

output "actions_runner_groups" {
  description = "Runner group associations"
  value       = module.github_repository.actions_runner_groups
}

output "actions_permissions" {
  description = "GitHub Actions permissions"
  value       = module.github_repository.actions_repository_permissions
}
