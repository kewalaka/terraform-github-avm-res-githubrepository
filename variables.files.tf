variable "files" {
  type = map(object({
    content                         = string
    file                            = string
    branch                          = optional(string, null)
    commit_message                  = optional(string, null)
    commit_author                   = optional(string, null)
    commit_email                    = optional(string, null)
    overwrite_on_create             = optional(bool, false)
    autocreate_branch               = optional(bool, false)
    autocreate_branch_source_branch = optional(string, "main")
    autocreate_branch_source_sha    = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
Map of files to be managed in the GitHub repository.

- `content` - The file content.
- `file` - The path of the file to manage.
- `branch` - (Optional) Git branch (defaults to the repository's default branch). The branch must already exist, it will only be created automatically if `autocreate_branch` is set to true.
- `commit_message` - (Optional) The commit message when creating, updating or deleting the managed file.
- `commit_author` - (Optional) Committer author name to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits.
- `commit_email` - (Optional) Committer email address to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits.
- `overwrite_on_create` - (Optional) Enable overwriting existing files. If set to true it will overwrite an existing file with the same name. If set to false it will fail if there is an existing file with the same name.
- `autocreate_branch` - (Optional) Automatically create the branch if it could not be found. Defaults to false.
- `autocreate_branch_source_branch` - (Optional) The branch name to start from, if `autocreate_branch` is set. Defaults to `main`.
- `autocreate_branch_source_sha` - (Optional) The commit hash to start from, if `autocreate_branch` is set. Defaults to the tip of `autocreate_branch_source_branch`. If provided, `autocreate_branch_source_branch` is ignored.
DESCRIPTION
}
