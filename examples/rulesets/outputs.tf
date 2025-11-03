# Output the created rulesets
output "repository_name" {
  description = "The name of the created repository"
  value       = module.github_repository.repository.name
}

output "repository_url" {
  description = "The URL of the created repository"
  value       = module.github_repository.repository.html_url
}

output "rulesets" {
  description = "The rulesets applied to the repository"
  value       = module.github_repository.rulesets
}
