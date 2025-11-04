# Terraform GitHub Repository module in the style of AVM

This is a module for creating GitHub repository and supporting child resources written in the style of Azure Verified Modules.

This has been submitted to the AVM team for consideration and should be considered unofficial.

The intention is to separately develop another module for GitHub Organizations and related components (terraform-github-avm-githuborganization).

## Features

- Create and manage GitHub repositories, branches & environments
- **Manage existing repositories** - Configure subcomponents (branches, environments, secrets, etc.) on pre-existing repositories
- Apply classic branches protection
- Apply repository rulesets (branch, tag, and push protection)
- Manage variables & secrets at the repository and environment scope.
- Enable or disable features such as issues, discussions, wiki, etc.

## Using Existing Repositories

The module can target already-created GitHub repositories while still managing subcomponents. This is useful when repositories are bootstrapped via other workflows, but you want to standardize governance and CI/CD surfaces.

To use an existing repository:

```hcl
module "existing_repo" {
  source = "path/to/module"

  name                    = "my-existing-repo"
  organization_name       = "my-org"
  use_existing_repository = true

  # Optional: provide repository_node_id for branch protection
  # If not provided, branch protection will be skipped
  repository_node_id = "R_kgDOHexample"

  # Configure subcomponents
  environments = { ... }
  secrets = { ... }
  variables = { ... }
}
```

**Resource Compatibility Matrix:**

| Resource Type | Requires node_id? | Works with name? |
|--------------|-------------------|------------------|
| Branches | No | Yes |
| Branch Protection | Yes | No |
| Rulesets | No | Yes |
| Environments | No | Yes |
| Secrets (Actions/Dependabot/Codespaces) | No | Yes |
| Variables (Actions) | No | Yes |
| Repository Files | No | Yes |
| Team Access | No | Yes |

**Note on Branch Protection:**
- When `use_existing_repository = true` and `repository_node_id` is not provided, branch protection will be skipped with a warning output.
- To enable branch protection on existing repositories, provide the `repository_node_id` (obtainable via GitHub API or GraphQL).
- Alternatively, use rulesets for equivalent protection without requiring the node ID.

## Migration from Branch Protection to Rulesets

Rulesets are the newer way to protect branches and tags, offering more flexibility than classic branch protection policies. Key advantages include:

- **Target flexibility**: Can protect branches, tags, or apply to push events
- **Better pattern matching**: More powerful include/exclude patterns with wildcards
- **Enforcement modes**: `active`, `evaluate` (for testing), and `disabled`
- **Bypass controls**: Granular control with bypass actors and modes

For new implementations, use rulesets instead of branch protection. See the `examples/rulesets` directory and the `modules/ruleset` submodule documentation for detailed usage.

TODO:

- Testing for adding team permissions
- Testing for adding files & using templates
- OIDC subject mapping
- Associating runner groups and apps
- Managing collaborators

.. probably more I haven't thought of yet!

## Testing locally

To test locally:

- set `GITHUB_OWNER` to your Github organisation or individual user account.
- install the GitHub CLI
- log in use `gh auth`
- fetch the token using `gh auth status -t`
- set `GITHUB_TOKEN` to the token value returned by the previous command.
