# GitHub Actions Repository Permissions Example

This example demonstrates how to configure GitHub Actions repository permissions with different security postures.

## Overview

This example creates three repositories with different GitHub Actions permission configurations:

1. **Local Actions Only** - Most restrictive, only actions defined in the repository are allowed
2. **Selected Actions** - Balanced approach with an allowlist of trusted actions
3. **All Actions** - Least restrictive, all actions are allowed (default)

## Supply Chain Security

GitHub Actions permissions are a critical supply-chain security control:

- **Restrict third-party actions**: Prevent supply-chain attacks by limiting which actions can run
- **Action allowlists**: Explicitly permit only trusted actions from verified sources
- **Local-only mode**: Maximum security by only allowing actions defined within your repository

## Configuration Examples

### Restrictive Configuration (local_only)
The most secure option - only actions defined in your repository can run:
```terraform
actions_permissions = {
  allowed_actions = "local_only"
  enabled         = true
}
```

### Allowlist Configuration (selected)
A balanced approach that allows specific trusted actions:
```terraform
actions_permissions = {
  allowed_actions = "selected"
  enabled         = true
  allowed_actions_config = {
    github_owned_allowed = true  # Allow GitHub's official actions
    verified_allowed     = false # Don't allow all verified creators
    patterns_allowed     = [
      "docker/*",                    # Allow all Docker actions
      "azure/webapps-deploy@v2",     # Specific Azure action
      "hashicorp/setup-terraform@v3" # Specific Terraform action
    ]
  }
}
```

### Permissive Configuration (all)
The default and least restrictive option:
```terraform
actions_permissions = {
  allowed_actions = "all"
  enabled         = true
}
```

## Trade-offs

| Configuration | Security | Flexibility | Maintenance |
|--------------|----------|-------------|-------------|
| `local_only` | Highest | Lowest | High (must duplicate actions) |
| `selected` | Moderate | Moderate | Moderate (maintain allowlist) |
| `all` | Lowest | Highest | Low (no restrictions) |

## Provider Documentation

See the [github_actions_repository_permissions](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) resource documentation for more details.

## Running this example

1. Set required environment variables:
   ```bash
   export TF_VAR_github_organization_name="your-org"
   export TF_VAR_github_app_id="your-app-id"
   export TF_VAR_github_app_installation_id="your-installation-id"
   export TF_VAR_github_app_pem_file="path/to/pem/file"
   ```

2. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
