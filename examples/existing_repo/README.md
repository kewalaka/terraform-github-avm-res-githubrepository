<!-- BEGIN_TF_DOCS -->
# Using an Existing Repository

This example demonstrates how to use the module with an existing GitHub repository without creating a new one.

## Overview

The example shows two patterns:

1. **Without repository\_node\_id**: Configure subcomponents (environments, secrets, variables) on an existing repository. Branch protection will be skipped with a warning.

2. **With repository\_node\_id**: Same as above, but also enable branch protection by providing the repository's node ID.

## How to Obtain repository\_node\_id

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

- [github_repository.external](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) (resource)
- [random_pet.repo_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id)

Description: The AppId of the GitHub App, used for authentication.

Type: `string`

### <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id)

Description: The installation id of the GitHub App, used for authentication.

Type: `string`

### <a name="input_github_app_pem_file"></a> [github\_app\_pem\_file](#input\_github\_app\_pem\_file)

Description: The contents of the PEM file for the GitHub App, used for authentication.

Type: `string`

### <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name)

Description: The name of the GitHub organization.

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

The following outputs are exported:

### <a name="output_branch_protection_warning_example1"></a> [branch\_protection\_warning\_example1](#output\_branch\_protection\_warning\_example1)

Description: Warning from example 1 (without node\_id)

### <a name="output_branch_protection_warning_example2"></a> [branch\_protection\_warning\_example2](#output\_branch\_protection\_warning\_example2)

Description: Warning from example 2 (with node\_id)

### <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name)

Description: The name of the managed repository

## Modules

The following Modules are called:

### <a name="module_existing_repo_with_node_id"></a> [existing\_repo\_with\_node\_id](#module\_existing\_repo\_with\_node\_id)

Source: ../../

Version:

### <a name="module_existing_repo_without_node_id"></a> [existing\_repo\_without\_node\_id](#module\_existing\_repo\_without\_node\_id)

Source: ../../

Version:

<!-- markdownlint-disable-next-line MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->