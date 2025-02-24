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

### <a name="input_branch_protection_policies"></a> [branch\_protection\_policies](#input\_branch\_protection\_policies)

Description: A map of branch protection policies to apply to the branches. The map key is the branch name.

- `enforce_admins` - (Optional) Boolean, setting this to true enforces status checks for repository administrators.
- `required_signed_commits` - (Optional) Boolean, setting this to true requires all commits to be signed with GPG.
- `required_linear_history` - (Optional) Boolean, setting this to true enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch.
- `require_conversation_resolution` - (Optional) Boolean, setting this to true requires all conversations on code must be resolved before a pull request can be merged.
- `allows_deletions` - (Optional) Boolean, setting this to true allows the branch to be deleted.
- `allows_force_pushes` - (Optional) Boolean, setting this to true allows force pushes on the branch to everyone. Set it to false if you specify `force_push_bypassers`.
- `lock_branch` - (Optional) Boolean, setting this to true will make the branch read-only and prevent any pushes to it. Defaults to false.
- `force_push_bypassers` - (Optional) List of actor Names/IDs that are allowed to bypass force push restrictions. Actor names must either begin with a "/" for users or the organization name followed by a "/" for teams. If the list is not empty, `allows_force_pushes` should be set to false.

- `required_status_checks` - (Optional) Enforce restrictions for required status checks.
  - `strict` - (Optional) Boolean, setting this to true requires branches to be up to date before merging.
  - `contexts` - (Optional) List of status check contexts that must pass before merging.

- `required_pull_request_reviews` - (Optional) Enforce restrictions for pull request reviews.
  - `dismiss_stale_reviews` - (Optional) Boolean, setting this to true dismisses stale pull request approvals when new commits are pushed.
  - `restrict_dismissals` - (Optional) Boolean, setting this to true restricts who can dismiss pull request reviews.
  - `dismissal_restrictions` - (Optional) List of users or teams that can dismiss pull request reviews.
  - `pull_request_bypassers` - (Optional) List of actor Names/IDs that are allowed to bypass pull request review restrictions.
  - `require_code_owner_reviews` - (Optional) Boolean, setting this to true requires an approving review from a code owner.
  - `required_approving_review_count` - (Optional) Number of approving reviews required before merging.
  - `require_last_push_approval` - (Optional) Boolean, setting this to true requires the most recent push to be approved by someone other than the pusher.

- `restrict_pushes` - (Optional) Restrict pushes to matching branches.
  - `users` - (Optional) List of users who can push to the branch.
  - `teams` - (Optional) List of teams who can push to the branch.
  - `apps` - (Optional) List of apps who can push to the branch.

Type:

```hcl
map(object({
    pattern = string

    enforce_admins                  = optional(bool, true)
    required_signed_commits         = optional(bool)
    required_linear_history         = optional(bool)
    require_conversation_resolution = optional(bool, true)
    force_push_bypassers            = optional(list(string))
    allows_deletions                = optional(bool)
    allows_force_pushes             = optional(bool, false)
    lock_branch                     = optional(bool, false)

    required_status_checks = optional(object({
      strict   = optional(bool, false)
      contexts = optional(list(string))
    }))

    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      restrict_dismissals             = bool
      dismissal_restrictions          = optional(list(string))
      pull_request_bypassers          = optional(list(string))
      require_code_owner_reviews      = optional(bool, true)
      required_approving_review_count = number
      require_last_push_approval      = optional(bool, true)
    }))

    restrict_pushes = optional(object({
      blocks_creations = optional(bool, true)
      push_allowances  = optional(list(string))
    }))
  }))
```

Default: `{}`

### <a name="input_branches"></a> [branches](#input\_branches)

Description: Map of branches to be created.

Type:

```hcl
map(object({
    name          = string
    source_branch = optional(string)
    source_sha    = optional(string)
  }))
```

Default: `{}`

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

Description: Map of environments to be created along with their associated github action secrets and variables.

Type:

```hcl
map(object({
    name      = string
    secrets   = map(string)
    variables = map(string)
  }))
```

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

### <a name="input_repository_secrets"></a> [repository\_secrets](#input\_repository\_secrets)

Description: Map of github action secrets to be created.

Type: `map(string)`

Default: `{}`

### <a name="input_repository_variables"></a> [repository\_variables](#input\_repository\_variables)

Description: Map of github action variables to be created.

Type: `map(string)`

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

### <a name="output_branches"></a> [branches](#output\_branches)

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

The following Modules are called:

### <a name="module_branch_protection_policies"></a> [branch\_protection\_policies](#module\_branch\_protection\_policies)

Source: ./modules/branch_protection

Version:

### <a name="module_branches"></a> [branches](#module\_branches)

Source: ./modules/branch

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->