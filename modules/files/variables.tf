variable "content" {
  type        = string
  description = "The file content."
  nullable    = false
}

variable "file" {
  type        = string
  description = "The path of the file to manage."
  nullable    = false
}

variable "repository_id" {
  type        = string
  description = "The id of the repository."
  nullable    = false
}

variable "autocreate_branch" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
Automatically create the branch if it could not be found. Defaults to false. 
Subsequent reads if the branch is deleted will occur from `autocreate_branch_source_branch`.
DESCRIPTION
}

variable "autocreate_branch_source_branch" {
  type        = string
  default     = "main"
  description = <<DESCRIPTION
The branch name to start from, if `autocreate_branch` is set. Defaults to `main`.
DESCRIPTION
}

variable "autocreate_branch_source_sha" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The commit hash to start from, if `autocreate_branch` is set. Defaults to the tip of `autocreate_branch_source_branch`. 
If provided, `autocreate_branch_source_branch` is ignored.
DESCRIPTION
}

variable "branch" {
  type        = string
  default     = null
  description = <<DESCRIPTION
Git branch (defaults to the repository's default branch). 
The branch must already exist, it will only be created automatically if `autocreate_branch` is set to true.
DESCRIPTION
}

variable "commit_author" {
  type        = string
  default     = null
  description = <<DESCRIPTION
Committer author name to use. 
NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. 
This may be useful when a branch protection rule requires signed commits.
DESCRIPTION
}

variable "commit_email" {
  type        = string
  default     = null
  description = <<DESCRIPTION
Committer email address to use. 
NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. 
This may be useful when a branch protection rule requires signed commits.
DESCRIPTION
}

variable "commit_message" {
  type        = string
  default     = null
  description = "The commit message when creating, updating or deleting the managed file."
}

variable "overwrite_on_create" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
Enable overwriting existing files. If set to true it will overwrite an existing file with the same name. 
If set to false it will fail if there is an existing file with the same name.
DESCRIPTION
}
