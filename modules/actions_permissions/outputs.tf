output "id" {
  description = "The repository name."
  value       = github_actions_repository_permissions.this.id
}

output "allowed_actions" {
  description = "The type of actions that are allowed."
  value       = github_actions_repository_permissions.this.allowed_actions
}

output "enabled" {
  description = "Whether GitHub Actions is enabled on the repository."
  value       = github_actions_repository_permissions.this.enabled
}
