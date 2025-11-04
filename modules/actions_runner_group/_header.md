# Github Actions Runner Group Association Submodule

This module is used to associate repositories with GitHub Actions runner groups and manage their configuration.

## Features

- Associate repositories with existing runner groups
- Manage workflow restrictions for runner groups
- Control public repository access for runner groups

## Usage

```terraform
module "avm_res_githubrepository_actions_runner_group" {
  source  = "Azure/avm-res-githubrepository/github//modules/actions_runner_group"
  version = "x.y.z"

  runner_group_id = 123
  repository      = { id = github_repository.this.id }
  
  # Optional: configure workflow restrictions
  restricted_to_workflows = true
  selected_workflows      = ["main.yml", ".github/workflows/deploy.yml"]
  
  # Optional: control public repository access
  allows_public_repositories = false
}
```

## Notes

- This module manages existing runner groups only; enterprise-level runner group creation is handled separately
- The runner group must already exist and have `visibility = "selected"` when associating repositories
- Workflow paths must be relative to the repository root
