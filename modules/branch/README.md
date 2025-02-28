<!-- BEGIN_TF_DOCS -->
# Github Repository Branch Submodule

This module is used to managed branches inside Github repositories.

## Features

Create a branch, optionally supplying a branch or commit SHA as the source.

Branch protection policies are created in separately in the `branch_protection` submodule, because they may apply to a pattern (e.g. *releases*) rather than a singular branch.

## Usage

TODO

```terraform
module "avm-res-githubrepository-branch" {
  source = "Azure/avm-res-githubrepository/github//modules/branch"

}
```

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5)

<!-- markdownlint-disable MD013 -->
## Resources

The following resources are used by this module:

- [github_branch.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the branch.

Type: `string`

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

### <a name="input_source_branch"></a> [source\_branch](#input\_source\_branch)

Description: The source branch.  Defaults to `main`.

Type: `string`

Default: `"main"`

### <a name="input_source_sha"></a> [source\_sha](#input\_source\_sha)

Description: The commit hash to start from, defaults to the tip of `source_branch`.  If provided, `source_branch` is ignored.

Type: `string`

Default: `null`

## Outputs

No outputs.

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->