<!-- BEGIN_TF_DOCS -->
# Github Repository Variables and Secrets Submodule

This module is used to manage variables and secrets inside Github repositories for both the repository and individual environments

## Features

Create secrets and variables at the following scopes:

* repository
* environment
* codespaces
* dependabot

It is proposed that secrets and variables at the organisation scope will use the GitHub Organization module (terraform-github-avm-githuborganization).

## Usage

TODO

```terraform
module "avm-res-githubrepository-secrets_and_variables" {
  source = "Azure/avm-res-githubrepository/github//modules/secrets_and_variables"

}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5)

## Resources

The following resources are used by this module:

- [github_actions_environment_secret.environment_secrets](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_secret) (resource)
- [github_actions_environment_variable.environment_variables](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_environment_variable) (resource)
- [github_actions_secret.secrets](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) (resource)
- [github_actions_variable.variables](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_variable) (resource)
- [github_codespaces_secret.codespaces_secrets](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/codespaces_secret) (resource)
- [github_dependabot_secret.dependabot_secrets](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/dependabot_secret) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

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

### <a name="input_secrets"></a> [secrets](#input\_secrets)

Description: Map of github action secrets to be created.

 - `name` - The name of the secret.
- `plaintext_value` - The plaintext value of the secret.
- `encrypted_value` - The encrypted value of the secret.
- `environment` - The environment to create the secret in. If not set, the secret will be created at the repository level.
- `is_dependabot_secret` - If set to true, the secret will be created at the repository level and will be used by dependabot.
- `is_codespaces_secret` - If set to true, the secret will be created at the repository level and will be used by codespaces.

Type:

```hcl
map(object({
    name                 = string
    plaintext_value      = optional(string)
    encrypted_value      = optional(string)
    environment          = optional(string)
    is_dependabot_secret = optional(bool, false)
    is_codespaces_secret = optional(bool, false)
  }))
```

Default: `{}`

### <a name="input_variables"></a> [variables](#input\_variables)

Description: Map of github action variables to be created.

- `name` - The name of the variable.
- `value` - The value of the variable.
- `environment` - The environment to create the variable in. If not set, the variable will be created at the repository level.

Type:

```hcl
map(object({
    name        = string
    value       = string
    environment = optional(string)
  }))
```

Default: `{}`

## Outputs

No outputs.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->