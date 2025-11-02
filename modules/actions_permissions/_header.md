# Github Repository Actions Permissions Submodule

This module manages GitHub Actions repository permissions to control allowed actions and default workflow permissions.

## Features

Configures GitHub Actions repository permissions including:
- Enabling/disabling GitHub Actions
- Controlling which actions are allowed (all, local only, or selected)
- Specifying allowlists for selected actions (GitHub-owned, verified creators, or specific patterns)

## Supply Chain Security

This module provides critical supply-chain and CI governance levers:
- **Restrict third-party actions**: Use `local_only` to only allow actions defined in your repository
- **Action allowlists**: Use `selected` with `allowed_actions_config` to specify exactly which actions are permitted
- **GitHub-owned actions**: Control whether actions from GitHub (e.g., `actions/checkout`) are allowed
- **Verified creators**: Control whether actions from GitHub Marketplace verified creators are allowed

## Usage

### Restrictive configuration (local actions only)
```terraform
module "actions_permissions" {
  source = "Azure/avm-res-githubrepository/github//modules/actions_permissions"

  repository = {
    id = "my-repo"
  }
  
  allowed_actions = "local_only"
  enabled         = true
}
```

### Allowlist configuration (selected actions)
```terraform
module "actions_permissions" {
  source = "Azure/avm-res-githubrepository/github//modules/actions_permissions"

  repository = {
    id = "my-repo"
  }
  
  allowed_actions = "selected"
  enabled         = true
  
  allowed_actions_config = {
    github_owned_allowed = true
    verified_allowed     = false
    patterns_allowed     = [
      "docker/*",
      "azure/webapps-deploy@v2"
    ]
  }
}
```

## Trade-offs

- **`all`**: Maximum flexibility but higher supply-chain risk from unrestricted third-party actions
- **`local_only`**: Maximum security but requires duplicating all actions in your repository
- **`selected`**: Balanced approach allowing specific trusted actions while blocking others

## Known Limitations

**Default Workflow Permissions**: The GitHub Terraform provider (v6.5) does not currently support configuring `default_workflow_permissions` (read vs write token scopes) at the repository level. This setting must be configured manually through the GitHub UI under Settings > Actions > General > Workflow permissions, or at the organization level.

**Fork Pull Request Approval**: Similarly, `require_approval_for_fork_pull_request` is not currently available in the Terraform provider at the repository level.

These limitations are due to the provider not yet exposing these API endpoints, not limitations of this module.

## Provider Documentation

See the [github_actions_repository_permissions](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) resource documentation for more details.
