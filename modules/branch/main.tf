resource "github_branch" "this" {
  repository    = var.repository.id
  branch        = var.name
  source_branch = var.source_branch
  source_sha    = var.source_sha
}
