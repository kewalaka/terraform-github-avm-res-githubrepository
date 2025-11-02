<!-- BEGIN_TF_DOCS -->
# GitHub Repository Actions Permissions Submodule

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

See the [github\_actions\_repository\_permissions](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) resource documentation for more details.

<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->  
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5)

<!-- markdownlint-disable MD013 -->
## Resources

The following resources are used by this module:

- [github_actions_repository_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_repository"></a> [repository](#input\_repository)

Description: The id of the repository.

Type:

```hcl
object({
    id = string
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_allowed_actions"></a> [allowed\_actions](#input\_allowed\_actions)

Description: The type of actions that are allowed. Possible values are:
- `all` - All actions are allowed.
- `local_only` - Only actions defined in this repository are allowed.
- `selected` - Only actions that match the `allowed_actions_config` are allowed.

Type: `string`

Default: `"all"`

### <a name="input_allowed_actions_config"></a> [allowed\_actions\_config](#input\_allowed\_actions\_config)

Description: Configuration for which actions are allowed when `allowed_actions` is set to `selected`.
- `github_owned_allowed` - Whether GitHub-owned actions are allowed. For example, actions from the `actions` organization.
- `patterns_allowed` - Specifies a list of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@*`, `monalisa/octocat@v2`, `monalisa/*`.
- `verified_allowed` - Whether actions from GitHub Marketplace verified creators are allowed. Set to `true` to allow all GitHub Marketplace verified creators, or `false` to disallow.

Type:

```hcl
object({
    github_owned_allowed = bool
    patterns_allowed     = list(string)
    verified_allowed     = optional(bool)
  })
```

Default:

```json
{
  "github_owned_allowed": true,
  "patterns_allowed": [],
  "verified_allowed": false
}
```

### <a name="input_enabled"></a> [enabled](#input\_enabled)

Description: Whether GitHub Actions is enabled on the repository.

Type: `bool`

Default: `true`

## Outputs

The following outputs are exported:

### <a name="output_allowed_actions"></a> [allowed\_actions](#output\_allowed\_actions)

Description: The type of actions that are allowed.

### <a name="output_enabled"></a> [enabled](#output\_enabled)

Description: Whether GitHub Actions is enabled on the repository.

### <a name="output_id"></a> [id](#output\_id)

Description: The repository name.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD013 -->
## Additional Information

For more information about GitHub Actions security best practices, see:
- [GitHub Actions Security Hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [Using third-party actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions#using-third-party-actions)
<!-- END_TF_DOCS -->