variable "actions_runner_groups" {
  type = map(object({
    name                       = string
    visibility                 = optional(string, "selected")
    allows_public_repositories = optional(bool, false)
    restricted_to_workflows    = optional(bool, false)
    selected_workflows         = optional(list(string), [])
    existing_repository_ids    = optional(list(number), [])
  }))
  default     = {}
  description = <<DESCRIPTION
A map of runner group associations to configure for this repository.

- `name` - (Required) The name of the runner group.
- `visibility` - (Optional) Visibility of the runner group. Must be 'selected' when associating with repositories. Defaults to 'selected'.
- `allows_public_repositories` - (Optional) Whether public repositories can use runners in this group. Defaults to false.
- `restricted_to_workflows` - (Optional) Whether this runner group can only be used for specific workflows. Defaults to false.
- `selected_workflows` - (Optional) List of workflows that can use this runner group. Only applies when restricted_to_workflows is true. Defaults to empty list.
- `existing_repository_ids` - (Optional) List of existing repository IDs already associated with this runner group. This ensures we don't remove them when adding the new repository. Defaults to empty list.

Example:
```terraform
actions_runner_groups = {
  "production" = {
    name                       = "production-runners"
    restricted_to_workflows    = true
    selected_workflows         = [".github/workflows/deploy.yml"]
    allows_public_repositories = false
    existing_repository_ids    = [123456, 789012]  # Other repos already in this group
  }
}
```

Note: You must import existing runner groups before managing them:
```
terraform import 'module.repo.module.actions_runner_groups["production"].github_actions_runner_group.this' <runner_group_id>
```

IMPORTANT: Each runner group can only be managed by one Terraform configuration.
If multiple configurations try to manage the same runner group, they will conflict.
Consider creating separate runner groups or managing them centrally.
DESCRIPTION
  nullable    = false
}

variable "actions_repository_permissions" {
  type = object({
    enabled         = optional(bool, true)
    allowed_actions = optional(string, "all")
    allowed_actions_config = optional(object({
      github_owned_allowed = optional(bool, true)
      patterns_allowed     = optional(list(string), [])
      verified_allowed     = optional(bool, false)
    }))
  })
  default     = {}
  description = <<DESCRIPTION
Configuration for GitHub Actions permissions at the repository level.

- `enabled` - (Optional) Whether GitHub Actions is enabled on the repository. Defaults to true.
- `allowed_actions` - (Optional) The permissions policy that controls the actions and reusable workflows that are allowed to run. Can be one of: 'all', 'local_only', or 'selected'. Defaults to 'all'.
- `allowed_actions_config` - (Optional) Configuration for allowed actions when allowed_actions is 'selected'.
  - `github_owned_allowed` - (Optional) Whether GitHub-owned actions are allowed. Defaults to true.
  - `patterns_allowed` - (Optional) List of action patterns allowed to run. Defaults to empty list.
  - `verified_allowed` - (Optional) Whether actions from verified creators are allowed. Defaults to false.

Example:
```terraform
actions_repository_permissions = {
  enabled         = true
  allowed_actions = "selected"
  allowed_actions_config = {
    github_owned_allowed = true
    patterns_allowed     = ["actions/*", "github/*"]
    verified_allowed     = true
  }
}
```
DESCRIPTION
  nullable    = false
}
