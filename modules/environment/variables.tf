variable "name" {
  type        = string
  description = "The name of the environment."
  nullable    = false
}

variable "repository" {
  type = object({
    id = string
  })
  description = "The id of the repository."
  nullable    = false
}

variable "can_admins_bypass" {
  type        = bool
  default     = null
  description = "Whether admins can bypass the environment policies."
}

variable "deployment_branch_policy" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
  })
  default = {
    protected_branches     = true
    custom_branch_policies = false
  }
  description = "The deployment branch policy for the environment."
  nullable    = false
}

variable "deployment_policy_branch_pattern" {
  type        = string
  default     = null
  description = "The deployment policy branch pattern for the environment."
}

variable "deployment_policy_tag_pattern" {
  type        = string
  default     = null
  description = "The deployment policy tag pattern for the environment."
}

variable "prevent_self_review" {
  type        = bool
  default     = null
  description = "Whether self-review is prevented in the environment."
}

variable "reviewers" {
  type = object({
    users = optional(list(string))
    teams = optional(list(string))
  })
  default     = {}
  description = "The reviewers for the environment."
  nullable    = false
}

variable "wait_timer" {
  type        = number
  default     = null
  description = "The wait timer for the environment."
}
