resource "github_repository_ruleset" "this" {
  name        = var.name
  repository  = var.repository.name
  target      = var.target
  enforcement = var.enforcement

  dynamic "bypass_actors" {
    for_each = var.bypass_actors
    content {
      actor_id    = bypass_actors.value.actor_id
      actor_type  = bypass_actors.value.actor_type
      bypass_mode = bypass_actors.value.bypass_mode
    }
  }

  conditions {
    ref_name {
      include = var.conditions.ref_name.include
      exclude = var.conditions.ref_name.exclude
    }
  }

  rules {
    # Pull request rules
    dynamic "pull_request" {
      for_each = var.rules.pull_request != null ? [var.rules.pull_request] : []
      content {
        dismiss_stale_reviews_on_push     = pull_request.value.dismiss_stale_reviews_on_push
        require_code_owner_review         = pull_request.value.require_code_owner_review
        require_last_push_approval        = pull_request.value.require_last_push_approval
        required_approving_review_count   = pull_request.value.required_approving_review_count
        required_review_thread_resolution = pull_request.value.required_review_thread_resolution
      }
    }

    # Status check rules
    dynamic "required_status_checks" {
      for_each = var.rules.required_status_checks != null ? [var.rules.required_status_checks] : []
      content {
        dynamic "required_check" {
          for_each = required_status_checks.value.required_check
          content {
            context        = required_check.value.context
            integration_id = required_check.value.integration_id
          }
        }
        strict_required_status_checks_policy = required_status_checks.value.strict_required_status_checks_policy
      }
    }

    # Commit pattern rules
    dynamic "committer_email_pattern" {
      for_each = var.rules.committer_email_pattern != null ? [var.rules.committer_email_pattern] : []
      content {
        operator = committer_email_pattern.value.operator
        pattern  = committer_email_pattern.value.pattern
        name     = committer_email_pattern.value.name
        negate   = committer_email_pattern.value.negate
      }
    }

    dynamic "commit_message_pattern" {
      for_each = var.rules.commit_message_pattern != null ? [var.rules.commit_message_pattern] : []
      content {
        operator = commit_message_pattern.value.operator
        pattern  = commit_message_pattern.value.pattern
        name     = commit_message_pattern.value.name
        negate   = commit_message_pattern.value.negate
      }
    }

    dynamic "commit_author_email_pattern" {
      for_each = var.rules.commit_author_email_pattern != null ? [var.rules.commit_author_email_pattern] : []
      content {
        operator = commit_author_email_pattern.value.operator
        pattern  = commit_author_email_pattern.value.pattern
        name     = commit_author_email_pattern.value.name
        negate   = commit_author_email_pattern.value.negate
      }
    }

    # Branch rules
    # The GitHub provider exposes these as optional boolean attributes on the rules block.
    # Setting them directly avoids unsupported dynamic blocks reported in Terraform plan output.
    creation                = var.rules.creation
    update                  = var.rules.update
    deletion                = var.rules.deletion
    required_linear_history = var.rules.required_linear_history
    required_signatures     = var.rules.required_signatures
    non_fast_forward        = var.rules.non_fast_forward
    update_allows_fetch_and_merge = (
      var.rules.update == null
      ? null
      : (var.rules.non_fast_forward != null ? !var.rules.non_fast_forward : true)
    )

    dynamic "required_deployments" {
      for_each = var.rules.required_deployments != null ? [var.rules.required_deployments] : []
      content {
        required_deployment_environments = required_deployments.value.required_deployment_environments
      }
    }

    # Tag rules
    dynamic "tag_name_pattern" {
      for_each = var.rules.tag_name_pattern != null ? [var.rules.tag_name_pattern] : []
      content {
        operator = tag_name_pattern.value.operator
        pattern  = tag_name_pattern.value.pattern
        name     = tag_name_pattern.value.name
        negate   = tag_name_pattern.value.negate
      }
    }

    # Workflow rules
    dynamic "required_workflows" {
      for_each = length(try(var.rules.required_workflows.required_workflow, [])) > 0 ? [var.rules.required_workflows] : []
      content {
        dynamic "required_workflow" {
          for_each = try(required_workflows.value.required_workflow, [])
          content {
            path          = required_workflow.value.path
            repository_id = required_workflow.value.repository_id
            ref           = required_workflow.value.ref
          }
        }
      }
    }
  }
}
