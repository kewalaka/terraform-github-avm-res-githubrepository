variable "name" {
  type        = string
  description = "The name of the branch."
  nullable    = false
}

variable "repository" {
  type = object({
    id = string
  })
  description = "The id of the repository."
  nullable    = false
}

variable "source_branch" {
  type        = string
  default     = "main"
  description = "The source branch.  Defaults to `main`."
}

variable "source_sha" {
  type        = string
  default     = null
  description = "The commit hash to start from, defaults to the tip of `source_branch`.  If provided, `source_branch` is ignored."
}
