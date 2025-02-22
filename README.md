<!-- BEGIN_TF_DOCS -->
# terraform-github-avm-repository

This is a module for creating GitHub repository and supporting child resources.

To test locally, set `GITHUB_OWNER` to your Github organisation or individual user account.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 2.2)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5)

- <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) (~> 0.3)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

## Resources

The following resources are used by this module:

- [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) (resource)
- [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) (resource)
- [github_team_repository.admin](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) (resource)
- [github_team_repository.maintain](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) (resource)
- [github_team_repository.pull](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) (resource)
- [github_team_repository.push](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) (resource)
- [modtm_telemetry.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/resources/telemetry) (resource)
- [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) (resource)
- [azapi_client_config.telemetry](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/client_config) (data source)
- [github_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) (data source)
- [modtm_module_source.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/data-sources/module_source) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of this resource.

Type: `string`

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: The name of the organization.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_approvers"></a> [approvers](#input\_approvers)

Description: A list of approvers.

Type: `list(string)`

Default: `[]`

### <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy)

Description: Archive repository instead of deleting it on destroy

Type: `bool`

Default: `true`

### <a name="input_create_branch_policies"></a> [create\_branch\_policies](#input\_create\_branch\_policies)

Description: Whether to create branch policies.

Type: `bool`

Default: `false`

### <a name="input_description"></a> [description](#input\_description)

Description: The description of the repository.

Type: `string`

Default: `""`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_environments"></a> [environments](#input\_environments)

Description: A map of environment names.

Type: `map(string)`

Default: `{}`

### <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions)

Description: Enable repository discussions

Type: `bool`

Default: `true`

### <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads)

Description: Enable repository downloads

Type: `bool`

Default: `true`

### <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues)

Description: Enable repository issues

Type: `bool`

Default: `true`

### <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects)

Description: Enable repository projects

Type: `bool`

Default: `false`

### <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki)

Description: Enable repository wiki

Type: `bool`

Default: `true`

### <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url)

Description: Repository homepage URL

Type: `string`

Default: `""`

### <a name="input_name_templates"></a> [name\_templates](#input\_name\_templates)

Description: The name of the templates repo to use.

Type: `string`

Default: `null`

### <a name="input_pages"></a> [pages](#input\_pages)

Description: The GitHub Pages configuration for the repository.

Type:

```hcl
object({
    branch = string
    path   = string
    cname  = string
  })
```

Default: `null`

### <a name="input_repository_files"></a> [repository\_files](#input\_repository\_files)

Description: A map of repository files with their content.

Type:

```hcl
map(object({
    content = string
  }))
```

Default: `{}`

### <a name="input_required_checks"></a> [required\_checks](#input\_required\_checks)

Description: List of required checks

Type: `list(string)`

Default: `[]`

### <a name="input_team_access"></a> [team\_access](#input\_team\_access)

Description: Team access types for created repository

Type:

```hcl
object({
    admin    = optional(list(string))
    maintain = optional(list(string))
    push     = optional(list(string))
    pull     = optional(list(string))
  })
```

Default:

```json
{
  "admin": [],
  "maintain": [],
  "pull": [],
  "push": []
}
```

### <a name="input_template_repository_files"></a> [template\_repository\_files](#input\_template\_repository\_files)

Description: A map of template repository files with their content.

Type:

```hcl
map(object({
    content = string
  }))
```

Default: `{}`

### <a name="input_topics"></a> [topics](#input\_topics)

Description: n/a

Type: `list(string)`

Default: `[]`

### <a name="input_type"></a> [type](#input\_type)

Description: Type of repository: `core`, `module`, `template`. Defaults to `core`

Type: `string`

Default: `"core"`

### <a name="input_use_template_repository"></a> [use\_template\_repository](#input\_use\_template\_repository)

Description: Whether to use the template repository.

Type: `bool`

Default: `false`

### <a name="input_visibility"></a> [visibility](#input\_visibility)

Description: The visibility of the repository.  Can be "public", "internal", or "private".

Only organizations associated with an enterprise can set visibility to internal

Type: `string`

Default: `"internal"`

### <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts)

Description: Enable vulnerability alerts

Type: `bool`

Default: `true`

### <a name="input_workflows"></a> [workflows](#input\_workflows)

Description: A map of workflows with their file names and environment user-assigned managed identity mappings.

Type:

```hcl
map(object({
    workflow_file_name = string
    environment_user_assigned_managed_identity_mappings = list(object({
      environment_key                    = string
      user_assigned_managed_identity_key = string
    }))
  }))
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_admins"></a> [admins](#output\_admins)

Description: n/a

### <a name="output_branch_protection"></a> [branch\_protection](#output\_branch\_protection)

Description: n/a

### <a name="output_maintainers"></a> [maintainers](#output\_maintainers)

Description: n/a

### <a name="output_pullers"></a> [pullers](#output\_pullers)

Description: n/a

### <a name="output_pushers"></a> [pushers](#output\_pushers)

Description: n/a

### <a name="output_repository"></a> [repository](#output\_repository)

Description: n/a

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->