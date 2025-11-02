# TODO consider something like this to abstract rules around how users + teams are specified.
# Actor names must either begin with a "/" for users or the organization name followed by a "/" for teams.
#push_allowances  = list(object({
#  users = optional(list(string))
#  teams = optional(list(string))
#}))
variable "branch_protection_policies" {
  type = map(object({
    pattern = string

    enforce_admins                  = optional(bool, true)
    required_signed_commits         = optional(bool)
    required_linear_history         = optional(bool)
    require_conversation_resolution = optional(bool, true)
    force_push_bypassers            = optional(list(string))
    allows_deletions                = optional(bool)
    allows_force_pushes             = optional(bool, false)
    lock_branch                     = optional(bool, false)

    required_status_checks = optional(object({
      strict   = optional(bool, false)
      contexts = optional(list(string))
    }))

    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      restrict_dismissals             = bool
      dismissal_restrictions          = optional(list(string))
      pull_request_bypassers          = optional(list(string))
      require_code_owner_reviews      = optional(bool, true)
      required_approving_review_count = number
      require_last_push_approval      = optional(bool, true)
    }))

    restrict_pushes = optional(object({
      blocks_creations = optional(bool, true)
      push_allowances  = optional(list(string))
    }))
  }))
  default     = {}
  description = <<DESCRIPTION
A map of branch protection policies to apply to the branches. The map key is the branch name.

- `enforce_admins` - (Optional) Boolean, setting this to true enforces status checks for repository administrators.
- `required_signed_commits` - (Optional) Boolean, setting this to true requires all commits to be signed with GPG.
- `required_linear_history` - (Optional) Boolean, setting this to true enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch.
- `require_conversation_resolution` - (Optional) Boolean, setting this to true requires all conversations on code must be resolved before a pull request can be merged.
- `allows_deletions` - (Optional) Boolean, setting this to true allows the branch to be deleted.
- `allows_force_pushes` - (Optional) Boolean, setting this to true allows force pushes on the branch to everyone. Set it to false if you specify `force_push_bypassers`.
- `lock_branch` - (Optional) Boolean, setting this to true will make the branch read-only and prevent any pushes to it. Defaults to false.
- `force_push_bypassers` - (Optional) List of actor Names/IDs that are allowed to bypass force push restrictions. Actor names must either begin with a "/" for users or the organization name followed by a "/" for teams. If the list is not empty, `allows_force_pushes` should be set to false.

- `required_status_checks` - (Optional) Enforce restrictions for required status checks.
  - `strict` - (Optional) Boolean, setting this to true requires branches to be up to date before merging.
  - `contexts` - (Optional) List of status check contexts that must pass before merging.

- `required_pull_request_reviews` - (Optional) Enforce restrictions for pull request reviews.
  - `dismiss_stale_reviews` - (Optional) Boolean, setting this to true dismisses stale pull request approvals when new commits are pushed.
  - `restrict_dismissals` - (Optional) Boolean, setting this to true restricts who can dismiss pull request reviews.
  - `dismissal_restrictions` - (Optional) List of users or teams that can dismiss pull request reviews.
  - `pull_request_bypassers` - (Optional) List of actor Names/IDs that are allowed to bypass pull request review restrictions.
  - `require_code_owner_reviews` - (Optional) Boolean, setting this to true requires an approving review from a code owner.
  - `required_approving_review_count` - (Optional) Number of approving reviews required before merging.
  - `require_last_push_approval` - (Optional) Boolean, setting this to true requires the most recent push to be approved by someone other than the pusher.

- `restrict_pushes` - (Optional) Restrict pushes to matching branches.
  - `users` - (Optional) List of users who can push to the branch.
  - `teams` - (Optional) List of teams who can push to the branch.
  - `apps` - (Optional) List of apps who can push to the branch.

DESCRIPTION
  nullable    = false
}

## Create a map of branches to be created
variable "branches" {
  type = map(object({
    name          = string
    source_branch = optional(string)
    source_sha    = optional(string)
  }))
  default     = {}
  description = "Map of branches to be created."
  nullable    = false
}
