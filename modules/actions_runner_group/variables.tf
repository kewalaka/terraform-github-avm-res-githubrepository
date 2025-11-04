variable "allows_public_repositories" {
  type        = bool
  default     = false
  description = "Whether public repositories can use runners in this group."
  nullable    = false
}

variable "existing_repository_ids" {
  type        = list(number)
  default     = []
  description = "List of existing repository IDs already associated with this runner group. This ensures we don't remove them when adding the new repository."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the runner group."
  nullable    = false
}

variable "repository" {
  type = object({
    id = number
  })
  description = "The repository object containing the numeric repository ID."
  nullable    = false
}

variable "restricted_to_workflows" {
  type        = bool
  default     = false
  description = "Whether this runner group can only be used for specific workflows."
  nullable    = false
}

variable "selected_workflows" {
  type        = list(string)
  default     = []
  description = "List of workflows that can use this runner group. Only applies when restricted_to_workflows is true."
  nullable    = false
}

variable "visibility" {
  type        = string
  default     = "selected"
  description = "Visibility of the runner group. Must be 'selected' when associating with repositories."
  nullable    = false

  validation {
    condition     = var.visibility == "selected"
    error_message = "Visibility must be 'selected' when associating repositories with a runner group."
  }
}
