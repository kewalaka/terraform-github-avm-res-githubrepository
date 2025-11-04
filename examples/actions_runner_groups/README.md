# GitHub Actions Runner Groups Example

This example demonstrates how to associate a repository with GitHub Actions runner groups and configure Actions permissions.

## Features Demonstrated

- Creating a repository with GitHub Actions permissions configured
- Associating the repository with an existing runner group
- Restricting runner group to specific workflows
- Controlling allowed actions and patterns

## Prerequisites

- An existing runner group in your GitHub organization
- The runner group ID (obtainable from GitHub API or UI)
- GitHub App authentication credentials

## Usage

1. Set the required variables:

```bash
export TF_VAR_github_organization_name="your-org"
export TF_VAR_github_app_id="123456"
export TF_VAR_github_app_installation_id="12345678"
export TF_VAR_github_app_pem_file="/path/to/private-key.pem"
export TF_VAR_runner_group_id=123  # Your runner group ID
```

2. Initialize and apply:

```bash
terraform init
terraform plan
terraform apply
```

## Important Notes

- Runner groups must already exist before using this module
- Enterprise-level runner group creation is handled by a separate module
- The runner group must have `visibility = "selected"` to associate repositories
- Workflow restrictions are optional but recommended for security

## Getting Runner Group ID

You can get the runner group ID using the GitHub CLI:

```bash
gh api orgs/YOUR_ORG/actions/runner-groups
```

Or using the GitHub API directly:

```bash
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/orgs/YOUR_ORG/actions/runner-groups
```
