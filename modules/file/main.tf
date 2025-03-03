resource "github_repository_file" "this" {
  repository                      = var.repository.id
  file                            = var.file
  content                         = var.content
  branch                          = var.branch
  commit_message                  = var.commit_message
  commit_author                   = var.commit_author
  commit_email                    = var.commit_email
  overwrite_on_create             = var.overwrite_on_create
  autocreate_branch               = var.autocreate_branch
  autocreate_branch_source_branch = var.autocreate_branch_source_branch
  autocreate_branch_source_sha    = var.autocreate_branch_source_sha
}
