# Manage the runner group to add this repository to selected_repository_ids
# This resource manages an existing runner group's repository associations.
#
# IMPORTANT: To use this module with an existing runner group:
# 1. Import the runner group state: terraform import module.actions_runner_groups["key"].github_actions_runner_group.this <runner_group_id>
# 2. Ensure you provide the current selected_repository_ids in your configuration
#
# WARNING: This will manage the full list of selected_repository_ids for the runner group.
# If multiple Terraform configurations manage the same runner group, this can cause conflicts.
# Consider using separate runner groups for different repositories or managing them centrally.

resource "github_actions_runner_group" "this" {
  name                       = var.name
  visibility                 = var.visibility
  allows_public_repositories = var.allows_public_repositories
  restricted_to_workflows    = var.restricted_to_workflows
  selected_workflows         = var.restricted_to_workflows ? var.selected_workflows : []

  # Include this repository in the selected_repository_ids
  # The full list of repository IDs must be provided, including existing ones
  selected_repository_ids = distinct(concat(
    var.existing_repository_ids,
    [var.repository.id]
  ))
}
