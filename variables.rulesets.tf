variable "rulesets" {
  type = map(object({
    name   = string
    target = string

    enforcement = optional(string, "active")

    bypass_actors = optional(list(object({
      actor_id    = number
      actor_type  = string
      bypass_mode = optional(string, "always")
    })), [])

    conditions = object({
      ref_name = object({
        include = list(string)
        exclude = optional(list(string), [])
      })
    })

    rules = optional(object({
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

    }), {})
  }))
  default     = {}
  description = <<-DESCRIPTION
    A map of rulesets to apply to the repository. The map key is a unique identifier for the ruleset.

    Each ruleset supports:
    - `name` - (Required) The name of the ruleset.
    - `target` - (Required) The target of the ruleset. Possible values: branch, tag, push.
    - `enforcement` - (Optional) The enforcement level. Possible values: disabled, active, evaluate. Defaults to active.
    - `bypass_actors` - (Optional) List of actors that can bypass the ruleset.
      - `actor_id` - The ID of the actor (user, team, or app).
      - `actor_type` - The type of actor. Possible values: RepositoryRole, Team, Integration, OrganizationAdmin.
      - `bypass_mode` - The bypass mode. Possible values: always, pull_request. Defaults to always.
    - `conditions` - (Required) Conditions for the ruleset.
      - `ref_name` - Reference name patterns to include and exclude.
        - `include` - List of ref name patterns to include (e.g., ["refs/heads/main", "refs/heads/release/*"]).
        - `exclude` - List of ref name patterns to exclude.
    - `rules` - (Optional) Rules to apply in the ruleset.
      - `pull_request` - Require pull request before merging.
      - `required_status_checks` - Require status checks to pass.
      - `required_code_scanning` - Require specific code scanning tooling.
      - `committer_email_pattern` - Require committer email to match pattern.
      - `commit_message_pattern` - Require commit message to match pattern.
      - `commit_author_email_pattern` - Require commit author email to match pattern.
      - `branch_name_pattern` - Require branch names to match a pattern.
      - `creation` - Block creation of matching refs.
      - `update` - Block update of matching refs.
      - `deletion` - Block deletion of matching refs.
      - `required_linear_history` - Require linear history.
      - `required_signatures` - Require signed commits.
      - `non_fast_forward` - Block non-fast-forward pushes.
      - `required_deployments` - Require deployments to succeed.
      - `file_extension_restriction` - Restrict commits based on file extensions.
      - `file_path_restriction` - Restrict commits based on file paths.
      - `max_file_size` - Restrict commits based on file sizes.
      - `merge_queue` - Require merges to pass through the merge queue.
      - `tag_name_pattern` - Require tag name to match pattern.

    See the ruleset submodule documentation for detailed information about each rule.
  DESCRIPTION
  nullable    = false
}
