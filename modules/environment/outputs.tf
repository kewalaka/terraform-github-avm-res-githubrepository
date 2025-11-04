output "environment_name" {
  description = "The name of the GitHub environment"
  value       = github_repository_environment.this.environment
}
