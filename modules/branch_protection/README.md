<!-- BEGIN_TF_DOCS -->
# Github Repository Branch Protection Policies Submodule

This module is used to manage branch protection policies inside Github repositories.

## Features

Create branch protection policies.

## Usage

TODO

```terraform
module "avm-res-githubrepository-branch" {
  source = "Azure/avm-res-githubrepository/github//modules/branch_protection"

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

- [github_branch_protection.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_pattern"></a> [pattern](#input\_pattern)

Description: The pattern that selects the applicable branches for this protection policy.

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

### <a name="input_allows_deletions"></a> [allows\_deletions](#input\_allows\_deletions)

Description: Setting this to true allows the branch to be deleted.

Type: `bool`

Default: `null`

### <a name="input_allows_force_pushes"></a> [allows\_force\_pushes](#input\_allows\_force\_pushes)

Description: Setting this to true allows force pushes on the branch to everyone. Set it to false if you specify force\_push\_bypassers.

Type: `bool`

Default: `false`

### <a name="input_enforce_admins"></a> [enforce\_admins](#input\_enforce\_admins)

Description: Setting this to true enforces status checks for repository administrators.

Type: `bool`

Default: `true`

### <a name="input_force_push_bypassers"></a> [force\_push\_bypassers](#input\_force\_push\_bypassers)

Description: The list of actor Names/IDs that are allowed to bypass force push restrictions. Actor names must either begin with a '/' for users or the organization name followed by a '/' for teams.

Type: `list(string)`

Default: `[]`

### <a name="input_lock_branch"></a> [lock\_branch](#input\_lock\_branch)

Description: Setting this to true will make the branch read-only and prevent any pushes to it.

Type: `bool`

Default: `false`

### <a name="input_require_conversation_resolution"></a> [require\_conversation\_resolution](#input\_require\_conversation\_resolution)

Description: Setting this to true requires all conversations on code must be resolved before a pull request can be merged.

Type: `bool`

Default: `true`

### <a name="input_required_linear_history"></a> [required\_linear\_history](#input\_required\_linear\_history)

Description: Setting this to true enforces a linear commit Git history, which prevents anyone from pushing merge commits to a branch.

Type: `bool`

Default: `null`

### <a name="input_required_pull_request_reviews"></a> [required\_pull\_request\_reviews](#input\_required\_pull\_request\_reviews)

Description: Enforce restrictions for pull request reviews.

Type:

```hcl
object({
    dismiss_stale_reviews           = optional(bool)
    restrict_dismissals             = optional(bool)
    dismissal_restrictions          = optional(list(string))
    pull_request_bypassers          = optional(list(string))
    require_code_owner_reviews      = optional(bool)
    required_approving_review_count = optional(number)
    require_last_push_approval      = optional(bool)
  })
```

Default: `{}`

### <a name="input_required_signed_commits"></a> [required\_signed\_commits](#input\_required\_signed\_commits)

Description: Setting this to true requires all commits to be signed with GPG.

Type: `bool`

Default: `null`

### <a name="input_required_status_checks"></a> [required\_status\_checks](#input\_required\_status\_checks)

Description: Enforce restrictions for required status checks.

Type:

```hcl
object({
    strict   = optional(bool)
    contexts = optional(list(string))
  })
```

Default: `{}`

### <a name="input_restrict_pushes"></a> [restrict\_pushes](#input\_restrict\_pushes)

Description: Restrict pushes to matching branches.

Type:

```hcl
object({
    blocks_creations = optional(bool)
    push_allowances  = optional(list(string))
  })
```

Default: `{}`

## Outputs

No outputs.

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->