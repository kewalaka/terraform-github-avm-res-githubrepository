output "id" {
  description = "The ID of the ruleset."
  value       = github_repository_ruleset.this.id
}

output "ruleset_id" {
  description = "The ruleset ID within GitHub."
  value       = github_repository_ruleset.this.ruleset_id
}

output "etag" {
  description = "The ETag of the ruleset."
  value       = github_repository_ruleset.this.etag
}

output "name" {
  description = "The name of the ruleset."
  value       = github_repository_ruleset.this.name
}

output "node_id" {
  description = "The Node ID of the ruleset."
  value       = github_repository_ruleset.this.node_id
}
