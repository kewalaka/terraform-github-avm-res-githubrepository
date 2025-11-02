<!-- BEGIN_TF_DOCS -->
# Terraform GitHub Repository module in the style of AVM

This is a module for creating GitHub repository and supporting child resources written in the style of Azure Verified Modules.

This has been submitted to the AVM team for consideration and should be considered unofficial.

The intention is to separately develop another module for GitHub Organizations and related components (terraform-github-avm-githuborganization).

## Features

- Create and manage GitHub repositories, branches & environments
- **Manage existing repositories** - Configure subcomponents (branches, environments, secrets, etc.) on pre-existing repositories
- Apply classic branches protection
- Manage variables & secrets at the repository and environment scope.
- Enable or disable features such as issues, discussions, wiki, etc.

## Using Existing Repositories

The module can target already-created GitHub repositories while still managing subcomponents. This is useful when repositories are bootstrapped via other workflows, but you want to standardize governance and CI/CD surfaces.

To use an existing repository:

```hcl
module "existing_repo" {
  source = "path/to/module"
  name                    = "my-existing-repo"
  organization_name       = "my-org"
  use_existing_repository = true
  # Optional: provide repository_node_id for branch protection
  # If not provided, branch protection will be skipped
  repository_node_id = "R_kgDOHexample"
  # Configure subcomponents
  environments = { ... }
  secrets = { ... }
  variables = { ... }
}
```

**Resource Compatibility Matrix:**

| Resource Type | Requires node\_id? | Works with name? |
|--------------|-------------------|------------------|
| Branches | No | Yes |
| Branch Protection | Yes | No |
| Environments | No | Yes |
| Secrets (Actions/Dependabot/Codespaces) | No | Yes |
| Variables (Actions) | No | Yes |
| Repository Files | No | Yes |
| Team Access | No | Yes |

**Note on Branch Protection:**
- When `use_existing_repository = true` and `repository_node_id` is not provided, branch protection will be skipped with a warning output.
- To enable branch protection on existing repositories, provide the `repository_node_id` (obtainable via GitHub API or GraphQL).
- Alternatively, consider using rulesets (when implemented) for equivalent protection without requiring the node ID.

TODO:

- Rulesets
- Testing for adding team permissions
- Testing for adding files & using templates
- OIDC subject mapping
- Associating runner groups and apps
- Managing collaborators

.. probably more I haven't thought of yet!

## Testing locally

To test locally:

- set `GITHUB_OWNER` to your Github organisation or individual user account.
- install the GitHub CLI
- log in use `gh auth`
- fetch the token using `gh auth status -t`
- set `GITHUB_TOKEN` to the token value returned by the previous command.

<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD013 -->  
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9, < 2.0 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | ~> 2.2 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.5 |
| <a name="requirement_modtm"></a> [modtm](#requirement\_modtm) | ~> 0.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.5 |

<!-- markdownlint-disable MD013 -->
## Resources

| Name | Type |
|------|------|
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_team_repository.admin](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.maintain](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.pull](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.push](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [modtm_telemetry.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/resources/telemetry) | resource |
| [random_uuid.telemetry](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [azapi_client_config.telemetry](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/client_config) | data source |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/organization) | data source |
| [modtm_module_source.telemetry](https://registry.terraform.io/providers/azure/modtm/latest/docs/data-sources/module_source) | data source |

<!-- markdownlint-disable MD013 -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of this resource. | `string` | n/a | yes |
| <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name) | The name of the organization. | `string` | n/a | yes |
| <a name="input_archive_on_destroy"></a> [archive\_on\_destroy](#input\_archive\_on\_destroy) | Archive repository instead of deleting it on destroy | `bool` | `true` | no |
| <a name="input_branch_protection_policies"></a> [branch\_protection\_policies](#input\_branch\_protection\_policies) | A map of branch protection policies to apply to the branches. The map key is the branch name.<br/><br/>- `enforce_admins` - (Optional) Boolean, setting this to true enforces status checks for repository administrators.<br/>- `required_signed_commits` - (Optional) Boolean, setting this to true requires all commits to be signed with GPG.<br/>- `required_linear_history` - (Optional) Boolean, setting this to true enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch.<br/>- `require_conversation_resolution` - (Optional) Boolean, setting this to true requires all conversations on code must be resolved before a pull request can be merged.<br/>- `allows_deletions` - (Optional) Boolean, setting this to true allows the branch to be deleted.<br/>- `allows_force_pushes` - (Optional) Boolean, setting this to true allows force pushes on the branch to everyone. Set it to false if you specify `force_push_bypassers`.<br/>- `lock_branch` - (Optional) Boolean, setting this to true will make the branch read-only and prevent any pushes to it. Defaults to false.<br/>- `force_push_bypassers` - (Optional) List of actor Names/IDs that are allowed to bypass force push restrictions. Actor names must either begin with a "/" for users or the organization name followed by a "/" for teams. If the list is not empty, `allows_force_pushes` should be set to false.<br/><br/>- `required_status_checks` - (Optional) Enforce restrictions for required status checks.<br/>  - `strict` - (Optional) Boolean, setting this to true requires branches to be up to date before merging.<br/>  - `contexts` - (Optional) List of status check contexts that must pass before merging.<br/><br/>- `required_pull_request_reviews` - (Optional) Enforce restrictions for pull request reviews.<br/>  - `dismiss_stale_reviews` - (Optional) Boolean, setting this to true dismisses stale pull request approvals when new commits are pushed.<br/>  - `restrict_dismissals` - (Optional) Boolean, setting this to true restricts who can dismiss pull request reviews.<br/>  - `dismissal_restrictions` - (Optional) List of users or teams that can dismiss pull request reviews.<br/>  - `pull_request_bypassers` - (Optional) List of actor Names/IDs that are allowed to bypass pull request review restrictions.<br/>  - `require_code_owner_reviews` - (Optional) Boolean, setting this to true requires an approving review from a code owner.<br/>  - `required_approving_review_count` - (Optional) Number of approving reviews required before merging.<br/>  - `require_last_push_approval` - (Optional) Boolean, setting this to true requires the most recent push to be approved by someone other than the pusher.<br/><br/>- `restrict_pushes` - (Optional) Restrict pushes to matching branches.<br/>  - `users` - (Optional) List of users who can push to the branch.<br/>  - `teams` - (Optional) List of teams who can push to the branch.<br/>  - `apps` - (Optional) List of apps who can push to the branch. | <pre>map(object({<br/>    pattern = string<br/><br/>    enforce_admins                  = optional(bool, true)<br/>    required_signed_commits         = optional(bool)<br/>    required_linear_history         = optional(bool)<br/>    require_conversation_resolution = optional(bool, true)<br/>    force_push_bypassers            = optional(list(string))<br/>    allows_deletions                = optional(bool)<br/>    allows_force_pushes             = optional(bool, false)<br/>    lock_branch                     = optional(bool, false)<br/><br/>    required_status_checks = optional(object({<br/>      strict   = optional(bool, false)<br/>      contexts = optional(list(string))<br/>    }))<br/><br/>    required_pull_request_reviews = optional(object({<br/>      dismiss_stale_reviews           = optional(bool, true)<br/>      restrict_dismissals             = bool<br/>      dismissal_restrictions          = optional(list(string))<br/>      pull_request_bypassers          = optional(list(string))<br/>      require_code_owner_reviews      = optional(bool, true)<br/>      required_approving_review_count = number<br/>      require_last_push_approval      = optional(bool, true)<br/>    }))<br/><br/>    restrict_pushes = optional(object({<br/>      blocks_creations = optional(bool, true)<br/>      push_allowances  = optional(list(string))<br/>    }))<br/>  }))</pre> | `{}` | no |
| <a name="input_branches"></a> [branches](#input\_branches) | Map of branches to be created. | <pre>map(object({<br/>    name          = string<br/>    source_branch = optional(string)<br/>    source_sha    = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the repository. | `string` | `""` | no |
| <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry) | This variable controls whether or not telemetry is enabled for the module.<br/>For more information see <https://aka.ms/avm/telemetryinfo>.<br/>If it is set to false, then no telemetry will be collected. | `bool` | `true` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | Map of environments to be created along with their associated github action secrets and variables.<br/><br/>- name: Name of the environment<br/>- reviewers: Up to 6 users and teams that are allowed to review deployments to this environment<br/>- deployment\_branch\_policy: Object containing the deployment branch policy<br/>  - protected\_branches: Boolean indicating if the branch is protected<br/>  - custom\_branch\_policies: Boolean indicating if custom branch policies are enabled<br/>- deployment\_policy\_branch\_pattern: Branch pattern for the deployment policy<br/>- deployment\_policy\_tag\_pattern: Tag pattern for the deployment policy | <pre>map(object({<br/>    name                = string<br/>    wait_timer          = optional(number)<br/>    can_admins_bypass   = optional(bool, true)<br/>    prevent_self_review = optional(bool, true)<br/>    reviewers = optional(object({<br/>      users = optional(list(number))<br/>      teams = optional(list(number))<br/>    }))<br/>    deployment_branch_policy = optional(object({<br/>      protected_branches     = optional(bool)<br/>      custom_branch_policies = optional(bool)<br/>    }))<br/>    deployment_policy_branch_pattern = optional(string)<br/>    deployment_policy_tag_pattern    = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_files"></a> [files](#input\_files) | Map of files to be managed in the GitHub repository.<br/><br/>- `content` - The file content.<br/>- `file` - The path of the file to manage.<br/>- `branch` - (Optional) Git branch (defaults to the repository's default branch). The branch must already exist, it will only be created automatically if `autocreate_branch` is set to true.<br/>- `commit_message` - (Optional) The commit message when creating, updating or deleting the managed file.<br/>- `commit_author` - (Optional) Committer author name to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits.<br/>- `commit_email` - (Optional) Committer email address to use. NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App. This may be useful when a branch protection rule requires signed commits.<br/>- `overwrite_on_create` - (Optional) Enable overwriting existing files. If set to true it will overwrite an existing file with the same name. If set to false it will fail if there is an existing file with the same name.<br/>- `autocreate_branch` - (Optional) Automatically create the branch if it could not be found. Defaults to false.<br/>- `autocreate_branch_source_branch` - (Optional) The branch name to start from, if `autocreate_branch` is set. Defaults to `main`.<br/>- `autocreate_branch_source_sha` - (Optional) The commit hash to start from, if `autocreate_branch` is set. Defaults to the tip of `autocreate_branch_source_branch`. If provided, `autocreate_branch_source_branch` is ignored. | <pre>map(object({<br/>    content                         = string<br/>    file                            = string<br/>    branch                          = optional(string, null)<br/>    commit_message                  = optional(string, null)<br/>    commit_author                   = optional(string, null)<br/>    commit_email                    = optional(string, null)<br/>    overwrite_on_create             = optional(bool, false)<br/>    autocreate_branch               = optional(bool, false)<br/>    autocreate_branch_source_branch = optional(string, "main")<br/>    autocreate_branch_source_sha    = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_github_advanced_security"></a> [github\_advanced\_security](#input\_github\_advanced\_security) | Options for configuring security and analysis features.<br/><br/>- `enable_advanced_security` - Whether to enable advanced security features.<br/>- `enable_secret_scanning` - Whether to enable secret scanning.<br/>- `enable_secret_scanning_push_protection` - Whether to enable secret scanning push protection. | <pre>object({<br/>    enable_advanced_security               = optional(bool)<br/>    enable_secret_scanning                 = optional(bool)<br/>    enable_secret_scanning_push_protection = optional(bool)<br/>  })</pre> | <pre>{<br/>  "enable_advanced_security": true,<br/>  "enable_secret_scanning": true,<br/>  "enable_secret_scanning_push_protection": true<br/>}</pre> | no |
| <a name="input_has_discussions"></a> [has\_discussions](#input\_has\_discussions) | Enable repository discussions | `bool` | `true` | no |
| <a name="input_has_downloads"></a> [has\_downloads](#input\_has\_downloads) | Enable repository downloads | `bool` | `true` | no |
| <a name="input_has_issues"></a> [has\_issues](#input\_has\_issues) | Enable repository issues | `bool` | `true` | no |
| <a name="input_has_projects"></a> [has\_projects](#input\_has\_projects) | Enable repository projects | `bool` | `false` | no |
| <a name="input_has_wiki"></a> [has\_wiki](#input\_has\_wiki) | Enable repository wiki | `bool` | `true` | no |
| <a name="input_homepage_url"></a> [homepage\_url](#input\_homepage\_url) | Repository homepage URL | `string` | `""` | no |
| <a name="input_pages"></a> [pages](#input\_pages) | The GitHub Pages configuration for the repository. | <pre>object({<br/>    branch = string<br/>    path   = string<br/>    cname  = string<br/>  })</pre> | `null` | no |
| <a name="input_repository_node_id"></a> [repository\_node\_id](#input\_repository\_node\_id) | The node ID of an existing repository. Required for branch protection when `use_existing_repository = true`. If not provided when using an existing repository, branch protection will be skipped. This can be obtained from the GitHub API or GraphQL. | `string` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Map of github action secrets to be created.<br/><br/>- `name` - The name of the secret.<br/>- `plaintext_value` - The plaintext value of the secret.<br/>- `encrypted_value` - The encrypted value of the secret.<br/>- `environment` - The environment to create the secret in. If not set, the secret will be created at the repository level.<br/>- `is_dependabot_secret` - If set to true, the secret will be created at the repository level and will be used by dependabot.<br/>- `is_codespaces_secret` - If set to true, the secret will be created at the repository level and will be used by codespaces. | <pre>map(object({<br/>    name                 = string<br/>    plaintext_value      = optional(string)<br/>    encrypted_value      = optional(string)<br/>    environment          = optional(string)<br/>    is_dependabot_secret = optional(bool, false)<br/>    is_codespaces_secret = optional(bool, false)<br/>  }))</pre> | `{}` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | Team access types for created repository | <pre>object({<br/>    admin    = optional(list(string))<br/>    maintain = optional(list(string))<br/>    push     = optional(list(string))<br/>    pull     = optional(list(string))<br/>    triage   = optional(list(string))<br/>  })</pre> | `{}` | no |
| <a name="input_template"></a> [template](#input\_template) | The template repository to use when creating the repository.<br/><br/>- `owner` (Optional) - The owner of the template repository.<br/>- `repository` (Optional) - The name of the template repository.<br/>- `include_all_branches` (Optional) - Whether to include all branches from the template repository. | <pre>object({<br/>    owner                = optional(string)<br/>    repository           = optional(string)<br/>    include_all_branches = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | values to use as topics for the repository | `list(string)` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of repository: `core`, `module`, `template`. Defaults to `core` | `string` | `"core"` | no |
| <a name="input_use_existing_repository"></a> [use\_existing\_repository](#input\_use\_existing\_repository) | Whether to use an existing repository instead of creating a new one. When true, the module will not create a github\_repository resource and will instead configure subcomponents (branches, environments, secrets, etc.) on the repository specified by the `name` variable. | `bool` | `false` | no |
| <a name="input_use_template_repository"></a> [use\_template\_repository](#input\_use\_template\_repository) | Whether to use the template repository. | `bool` | `false` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | Map of github action variables to be created.<br/><br/>- `name` - The name of the variable.<br/>- `value` - The value of the variable.<br/>- `environment` - The environment to create the variable in. If not set, the variable will be created at the repository level. | <pre>map(object({<br/>    name        = string<br/>    value       = string<br/>    environment = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | The visibility of the repository.  Can be "public", "internal", or "private".<br/><br/>Only organizations associated with an enterprise can set visibility to internal | `string` | `"internal"` | no |
| <a name="input_vulnerability_alerts"></a> [vulnerability\_alerts](#input\_vulnerability\_alerts) | Enable vulnerability alerts | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admins"></a> [admins](#output\_admins) | Teams with admin permissions to the repository. |
| <a name="output_branch_protection"></a> [branch\_protection](#output\_branch\_protection) | Branch protection policies applied to the repository. |
| <a name="output_branch_protection_warning"></a> [branch\_protection\_warning](#output\_branch\_protection\_warning) | Warning message if branch protection is skipped when using an existing repository without repository\_node\_id. |
| <a name="output_branches"></a> [branches](#output\_branches) | Branch configurations created by the branches module. |
| <a name="output_maintainers"></a> [maintainers](#output\_maintainers) | Teams with maintain permissions to the repository. |
| <a name="output_pullers"></a> [pullers](#output\_pullers) | Teams with read permissions (pull) to the repository. |
| <a name="output_pushers"></a> [pushers](#output\_pushers) | Teams with write permissions (push) to the repository. |
| <a name="output_repository"></a> [repository](#output\_repository) | The GitHub repository resource created by this module. Null when use\_existing\_repository is true. |
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | The name of the repository (either created or existing). |
| <a name="output_resource_id"></a> [resource\_id](#output\_resource\_id) | The ID of the repository (name for existing repos, full ID for created repos). |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_branch_protection_policies"></a> [branch\_protection\_policies](#module\_branch\_protection\_policies) | ./modules/branch_protection | n/a |
| <a name="module_branches"></a> [branches](#module\_branches) | ./modules/branch | n/a |
| <a name="module_environments"></a> [environments](#module\_environments) | ./modules/environment | n/a |
| <a name="module_file"></a> [file](#module\_file) | ./modules/file | n/a |
| <a name="module_secret"></a> [secret](#module\_secret) | ./modules/secret | n/a |
| <a name="module_variable"></a> [variable](#module\_variable) | ./modules/variable | n/a |

<!-- markdownlint-disable-next-line MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->