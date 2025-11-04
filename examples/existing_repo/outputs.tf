output "repository_name" {
  description = "The name of the managed repository"
  value       = module.existing_repo_without_node_id.repository_name
}
