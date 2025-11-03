# Terraform GitHub Repository module in the style of AVM

This is a module for creating GitHub repository and supporting child resources written in the style of Azure Verified Modules.

This has been submitted to the AVM team for consideration and should be considered unofficial.

The intention is to separately develop another module for GitHub Organizations and related components (terraform-github-avm-githuborganization).

## Features

- Create and manage GitHub repositories, branches & environments
- Apply classic branches protection
- Apply repository rulesets (branch, tag, and push protection)
- Manage variables & secrets at the repository and environment scope.
- Enable or disable features such as issues, discussions, wiki, etc.

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
