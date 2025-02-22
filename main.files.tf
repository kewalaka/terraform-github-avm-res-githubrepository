# resource "github_repository_file" "this" {
#   for_each            = var.repository_files
#   repository          = github_repository.this.name
#   file                = each.key
#   content             = each.value.content
#   commit_author       = local.default_commit_email
#   commit_email        = local.default_commit_email
#   commit_message      = "Add ${each.key} [skip ci]"
#   overwrite_on_create = true
# }
