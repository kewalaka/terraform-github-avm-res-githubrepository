<!-- BEGIN_TF_DOCS -->
# Github Repository Branch Protection Policies Submodule

This module is used to manage environments inside Github repositories.

## Features

Create environments

## Usage

TODO

```terraform
module "avm-res-githubrepository-branch" {
  source = "Azure/avm-res-githubrepository/github//modules/environments"

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

- [github_repository_environment.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment) (resource)
- [github_repository_environment_deployment_policy.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_environment_deployment_policy) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the environment.

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

### <a name="input_can_admins_bypass"></a> [can\_admins\_bypass](#input\_can\_admins\_bypass)

Description: Whether admins can bypass the environment policies.

Type: `bool`

Default: `null`

### <a name="input_deployment_branch_policy"></a> [deployment\_branch\_policy](#input\_deployment\_branch\_policy)

Description: The deployment branch policy for the environment.

Type:

```hcl
object({
    protected_branches     = bool
    custom_branch_policies = bool
  })
```

Default:

```json
{
  "custom_branch_policies": false,
  "protected_branches": true
}
```

### <a name="input_deployment_policy_branch_pattern"></a> [deployment\_policy\_branch\_pattern](#input\_deployment\_policy\_branch\_pattern)

Description: The deployment policy branch pattern for the environment.

Type: `string`

Default: `null`

### <a name="input_deployment_policy_tag_pattern"></a> [deployment\_policy\_tag\_pattern](#input\_deployment\_policy\_tag\_pattern)

Description: The deployment policy tag pattern for the environment.

Type: `string`

Default: `null`

### <a name="input_prevent_self_review"></a> [prevent\_self\_review](#input\_prevent\_self\_review)

Description: Whether self-review is prevented in the environment.

Type: `bool`

Default: `null`

### <a name="input_reviewers"></a> [reviewers](#input\_reviewers)

Description: The reviewers for the environment.

Type:

```hcl
object({
    users = optional(list(string))
    teams = optional(list(string))
  })
```

Default: `{}`

### <a name="input_wait_timer"></a> [wait\_timer](#input\_wait\_timer)

Description: The wait timer for the environment.

Type: `number`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id)

Description: TODO fix later - keep the lint rules quiet.

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->