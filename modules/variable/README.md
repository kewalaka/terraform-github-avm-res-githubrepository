<!-- BEGIN_TF_DOCS -->
# Github Repository Variables and Secrets Submodule

This module is used to manage variables and secrets inside Github repositories
for both the repository and individual environments

## Features

Create a Github secret at the following scopes:

- repository
- environment
- codespaces
- dependabot

It is proposed that secrets at the organisation scope will use the GitHub
Organization module (terraform-github-avm-githuborganization).

## Usage

```terraform
locals {
  variables = {
    repo1 = {
      name            = "REPO_VARIABLE_1"
      plaintext_value = "supersecretvalue"
    }
    env1 = {
      name            = "ENV_VARIABLE_1"
      plaintext_value = "anothersecretvalue"
      environment     = "production"
    }
  }
}

module "avm_res_githubrepository_secret" {
  source  = "Azure/avm-res-githubrepository/github//modules/variable"
  version = "x.y.z"

  for_each = local.variables

  repository = { id = github_repository.this.id }

  name            = each.value.name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
  environment     = each.value.environmnet
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

- [github_actions_environment_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) (resource)
- [github_actions_variable.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the secret.

Type: `string`

### <a name="input_repository"></a> [repository](#input\_repository)

Description: The id of the repository.

Type:

```hcl
object({
    id = string
  })
```

### <a name="input_value"></a> [value](#input\_value)

Description: The plaintext value of the secret.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_environment"></a> [environment](#input\_environment)

Description: The environment to create the secret in. If not set, the secret will be created at the repository level.

Type: `string`

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