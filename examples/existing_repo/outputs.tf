# Output warnings if branch protection is skipped
output "branch_protection_warning_example1" {
  description = "Warning from example 1 (without node_id)"
  value       = module.existing_repo_without_node_id.branch_protection_warning
}

output "branch_protection_warning_example2" {
  description = "Warning from example 2 (with node_id)"
  value       = module.existing_repo_with_node_id.branch_protection_warning
}

output "repository_name" {
  description = "The name of the managed repository"
  value       = module.existing_repo_without_node_id.repository_name
}
