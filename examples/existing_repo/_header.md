# Using an Existing Repository

This example demonstrates how to use the module with an existing GitHub repository without creating a new one.

## Overview

The example shows two patterns:

1. **Without repository_node_id**: Configure subcomponents (environments, secrets, variables) on an existing repository. Branch protection will be skipped with a warning.

2. **With repository_node_id**: Same as above, but also enable branch protection by providing the repository's node ID.

## How to Obtain repository_node_id

If you want to enable branch protection on an existing repository, you'll need to obtain its node ID. You can get this via:

**Using GitHub CLI:**
```bash
gh api graphql -f query='
  query($owner: String!, $name: String!) {
    repository(owner: $owner, name: $name) {
      id
    }
  }
' -f owner=YOUR_ORG -f name=YOUR_REPO
```

**Using the Terraform GitHub provider:**
Create a data source in your Terraform code (outside this module):
```hcl
data "github_repository" "existing" {
  name = "my-existing-repo"
}

# Use: data.github_repository.existing.node_id
```

## GitHub App Permissions Required

- Repository Contents: write (for branches, files)
- Repository Administration: write (for branch protection, environments)
- Repository Environments: write
- Repository Secrets: write
- Repository Codespaces secrets: write (optional, if setting these)
- Repository Dependabot secrets: write (optional, if setting these)

ref: <https://docs.github.com/en/rest/actions/secrets?apiVersion=2022-11-28#create-or-update-an-environment-secret>
