

variable "create_branch_policies" {
  type        = bool
  description = <<DESCRIPTION
Whether to create branch policies.
DESCRIPTION
  default     = false
  nullable    = false
}

## Create a map of branches to be created along with their branch protection policies
variable "branches" {
  type = map(object({
    name               = string
    protection_enabled = bool
    protection = object({
      enforce_admins                  = bool
      required_linear_history         = bool
      require_conversation_resolution = bool
      required_pull_request_reviews = object({
        dismiss_stale_reviews           = bool
        restrict_dismissals             = bool
        required_approving_review_count = number
      })
    })
  }))
  description = <<DESCRIPTION
Map of branches to be created along with their branch protection policies.
DESCRIPTION
  default     = {}
  nullable    = false
}
