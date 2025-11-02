<!-- BEGIN_TF_DOCS -->
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

### Restrictive Configuration (local\_only)
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

See the [github\_actions\_repository\_permissions](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) resource documentation for more details.

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

<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->  
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

<!-- markdownlint-disable MD013 -->
## Resources

The following resources are used by this module:

- [random_pet.repo_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id)

Description: The GitHub App ID for authentication.

Type: `string`

### <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id)

Description: The GitHub App installation ID for authentication.

Type: `string`

### <a name="input_github_app_pem_file"></a> [github\_app\_pem\_file](#input\_github\_app\_pem\_file)

Description: The path to the GitHub App PEM file for authentication.

Type: `string`

### <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name)

Description: The GitHub organization name.

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

No outputs.

## Modules

The following Modules are called:

### <a name="module_github_repository_all_actions"></a> [github\_repository\_all\_actions](#module\_github\_repository\_all\_actions)

Source: ../../

Version:

### <a name="module_github_repository_local_only"></a> [github\_repository\_local\_only](#module\_github\_repository\_local\_only)

Source: ../../

Version:

### <a name="module_github_repository_selected"></a> [github\_repository\_selected](#module\_github\_repository\_selected)

Source: ../../

Version:

<!-- markdownlint-disable-next-line MD013 -->
## Additional Resources

- [GitHub Actions Security Hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [Using third-party actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions#using-third-party-actions)
- [Allowing select actions to run](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository#allowing-select-actions-to-run)
<!-- END_TF_DOCS -->