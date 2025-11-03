variable "conditions" {
  type = object({
    ref_name = object({
      include = list(string)
      exclude = optional(list(string), [])
    })
  })
  description = <<-EOT
    Conditions for the ruleset.
    - ref_name: Reference name patterns to include and exclude.
      - include: List of ref name patterns to include (e.g., ["refs/heads/main", "refs/heads/release/*"]).
      - exclude: List of ref name patterns to exclude (e.g., ["refs/heads/dev"]).
  EOT
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the ruleset."
  nullable    = false
}

variable "repository" {
  type = object({
    id   = string
    name = string
  })
  description = "The repository object containing id and name."
  nullable    = false
}

variable "target" {
  type        = string
  description = "The target of the ruleset. Possible values are: branch, tag, push."
  nullable    = false

  validation {
    condition     = contains(["branch", "tag", "push"], var.target)
    error_message = "Target must be one of: branch, tag, push."
  }
}

variable "bypass_actors" {
  type = list(object({
    actor_id    = number
    actor_type  = string
    bypass_mode = optional(string, "always")
  }))
  default     = []
  description = <<-EOT
    List of actors that can bypass the ruleset.
    - actor_id: The ID of the actor (user, team, or app).
    - actor_type: The type of actor. Possible values: RepositoryRole, Team, Integration, OrganizationAdmin.
    - bypass_mode: The bypass mode. Possible values: always, pull_request. Defaults to always.
  EOT
}

variable "enforcement" {
  type        = string
  default     = "active"
  description = "The enforcement level of the ruleset. Possible values are: disabled, active, evaluate."

  validation {
    condition     = contains(["disabled", "active", "evaluate"], var.enforcement)
    error_message = "Enforcement must be one of: disabled, active, evaluate."
  }
}

variable "rules" {
  type = object({
    # Pull request rules
    pull_request = optional(object({
      dismiss_stale_reviews_on_push     = optional(bool, false)
      require_code_owner_review         = optional(bool, false)
      require_last_push_approval        = optional(bool, false)
      required_approving_review_count   = optional(number, 1)
      required_review_thread_resolution = optional(bool, false)
    }))

    # Status check rules
    required_status_checks = optional(object({
      required_check = list(object({
        context        = string
        integration_id = optional(number)
      }))
      do_not_enforce_on_create             = optional(bool, false)
      strict_required_status_checks_policy = optional(bool, false)
    }))

    required_code_scanning = optional(object({
      required_code_scanning_tool = set(object({
        tool                      = string
        alerts_threshold          = string
        security_alerts_threshold = string
      }))
    }))

    # Commit rules
    committer_email_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    commit_message_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    commit_author_email_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    branch_name_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    # Branch rules
    creation                = optional(bool)
    update                  = optional(bool)
    deletion                = optional(bool)
    required_linear_history = optional(bool)
    required_signatures     = optional(bool)
    non_fast_forward        = optional(bool)
    required_deployments = optional(object({
      required_deployment_environments = list(string)
    }))

    file_extension_restriction = optional(object({
      restricted_file_extensions = set(string)
    }))

    file_path_restriction = optional(object({
      restricted_file_paths = list(string)
    }))

    max_file_size = optional(object({
      max_file_size = number
    }))

    merge_queue = optional(object({
      check_response_timeout_minutes    = optional(number)
      grouping_strategy                 = optional(string)
      max_entries_to_build              = optional(number)
      max_entries_to_merge              = optional(number)
      merge_method                      = optional(string)
      min_entries_to_merge              = optional(number)
      min_entries_to_merge_wait_minutes = optional(number)
    }))

    # Tag rules
    tag_name_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

  })
  default     = {}
  description = <<-EOT
    Rules to apply in the ruleset. All rules are optional.

    Pull Request Rules:
    - pull_request: Require pull request before merging.
      - dismiss_stale_reviews_on_push: Dismiss stale reviews on push.
      - require_code_owner_review: Require code owner review.
      - require_last_push_approval: Require approval of the most recent push.
      - required_approving_review_count: Number of required approving reviews.
      - required_review_thread_resolution: Require all conversations to be resolved.

    Status and Scanning Rules:
    - required_status_checks: Require status checks to pass.
      - required_check: List of required status checks.
        - context: The status check context name.
        - integration_id: Optional integration ID.
      - do_not_enforce_on_create: Allow branch creation when checks are pending.
      - strict_required_status_checks_policy: Require branches to be up to date.
    - required_code_scanning: Require code scanning tools to pass.
      - required_code_scanning_tool: Set of scanning tools to enforce.
        - tool: Name of the scanning tool.
        - alerts_threshold: Severity level that blocks updates.
        - security_alerts_threshold: Security severity level that blocks updates.

    Commit Rules:
    - committer_email_pattern: Require committer email to match pattern.
    - commit_message_pattern: Require commit message to match pattern.
    - commit_author_email_pattern: Require commit author email to match pattern.
      Each pattern object contains:
      - operator: The operator (starts_with, ends_with, contains, regex).
      - pattern: The pattern to match.
      - name: Optional name for the rule.
      - negate: Whether to negate the match.

    Branch Rules:
    - branch_name_pattern: Require branch names to match a pattern.
    - creation: Block creation of matching refs.
    - update: Block update of matching refs (set to true with update_allows_fetch_and_merge = true for non-fast-forward rule).
    - deletion: Block deletion of matching refs.
    - required_linear_history: Require linear history.
    - required_signatures: Require signed commits.
    - non_fast_forward: Block non-fast-forward pushes.
    - required_deployments: Require deployments to succeed.
      - required_deployment_environments: List of required deployment environments.
    - file_extension_restriction: Restrict pushes by file extension.
    - file_path_restriction: Restrict pushes by file path.
    - max_file_size: Restrict pushes by maximum file size.
    - merge_queue: Require merges to flow through the merge queue.

    Tag Rules:
    - tag_name_pattern: Require tag name to match pattern (similar structure to commit patterns).
  EOT
}
