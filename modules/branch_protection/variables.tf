variable "pattern" {
  type        = string
  description = "The pattern that selects the applicable branches for this protection policy."
  nullable    = false
}

variable "repository" {
  type = object({
    id = string
  })
  description = "The id of the repository."
  nullable    = false
}

variable "allows_deletions" {
  type        = bool
  default     = null
  description = "Setting this to true allows the branch to be deleted."
}

variable "allows_force_pushes" {
  type        = bool
  default     = false
  description = "Setting this to true allows force pushes on the branch to everyone. Set it to false if you specify force_push_bypassers."
}

variable "enforce_admins" {
  type        = bool
  default     = true
  description = "Setting this to true enforces status checks for repository administrators."
}

variable "force_push_bypassers" {
  type        = list(string)
  default     = []
  description = "The list of actor Names/IDs that are allowed to bypass force push restrictions. Actor names must either begin with a '/' for users or the organization name followed by a '/' for teams."
}

variable "lock_branch" {
  type        = bool
  default     = false
  description = "Setting this to true will make the branch read-only and prevent any pushes to it."
}

variable "require_conversation_resolution" {
  type        = bool
  default     = true
  description = "Setting this to true requires all conversations on code must be resolved before a pull request can be merged."
}

variable "required_linear_history" {
  type        = bool
  default     = null
  description = "Setting this to true enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch."
}

variable "required_pull_request_reviews" {
  type = object({
    dismiss_stale_reviews           = optional(bool)
    restrict_dismissals             = optional(bool)
    dismissal_restrictions          = optional(list(string))
    pull_request_bypassers          = optional(list(string))
    require_code_owner_reviews      = optional(bool)
    required_approving_review_count = optional(number)
    require_last_push_approval      = optional(bool)
  })
  default     = {}
  description = "Enforce restrictions for pull request reviews."
}

variable "required_signed_commits" {
  type        = bool
  default     = null
  description = "Setting this to true requires all commits to be signed with GPG."
}

variable "required_status_checks" {
  type = object({
    strict   = optional(bool)
    contexts = optional(list(string))
  })
  default     = {}
  description = "Enforce restrictions for required status checks."
}

variable "restrict_pushes" {
  type = object({
    blocks_creations = optional(bool)
    push_allowances  = optional(list(string))
  })
  default     = {}
  description = "Restrict pushes to matching branches."
}
