variable "repository" {
  type = object({
    id = string
  })
  description = "The id of the repository."
  nullable    = false
}

variable "allowed_actions" {
  type        = string
  default     = "all"
  description = <<DESCRIPTION
The type of actions that are allowed. Possible values are:
- `all` - All actions are allowed.
- `local_only` - Only actions defined in this repository are allowed.
- `selected` - Only actions that match the `allowed_actions_config` are allowed.
DESCRIPTION

  validation {
    condition     = contains(["all", "local_only", "selected"], var.allowed_actions)
    error_message = "allowed_actions must be one of: all, local_only, selected"
  }
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether GitHub Actions is enabled on the repository."
}

variable "allowed_actions_config" {
  type = object({
    github_owned_allowed = bool
    patterns_allowed     = list(string)
    verified_allowed     = optional(bool)
  })
  default = {
    github_owned_allowed = true
    patterns_allowed     = []
    verified_allowed     = false
  }
  description = <<DESCRIPTION
Configuration for which actions are allowed when `allowed_actions` is set to `selected`.
- `github_owned_allowed` - Whether GitHub-owned actions are allowed. For example, actions from the `actions` organization.
- `patterns_allowed` - Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@*`, `monalisa/octocat@v2`, `monalisa/*`.
- `verified_allowed` - Whether actions from GitHub Marketplace verified creators are allowed. Set to `true` to allow all GitHub Marketplace verified creators, or `false` to disallow.
DESCRIPTION
  nullable    = false
}
