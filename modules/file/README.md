<!-- BEGIN_TF_DOCS -->
# Github Repository Files Submodule

This module is used to manage file contents inside a repository

## Usage

```terraform
locals {
  files = {
  }
}

module "avm_res_githubrepository_file" {
  source  = "Azure/avm-res-githubrepository/github//modules/file"
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

- [github_repository_file.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_content"></a> [content](#input\_content)

Description: The file content.

Type: `string`

### <a name="input_file"></a> [file](#input\_file)

Description: The path of the file to manage.

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

### <a name="input_autocreate_branch"></a> [autocreate\_branch](#input\_autocreate\_branch)

Description: Automatically create the branch if it could not be found. Defaults to false.   
Subsequent reads if the branch is deleted will occur from `autocreate_branch_source_branch`.

Type: `bool`

Default: `false`

### <a name="input_autocreate_branch_source_branch"></a> [autocreate\_branch\_source\_branch](#input\_autocreate\_branch\_source\_branch)

Description: The branch name to start from, if `autocreate_branch` is set. Defaults to `main`.

Type: `string`

Default: `"main"`

### <a name="input_autocreate_branch_source_sha"></a> [autocreate\_branch\_source\_sha](#input\_autocreate\_branch\_source\_sha)

Description: The commit hash to start from, if `autocreate_branch` is set. Defaults to the tip of `autocreate_branch_source_branch`.   
If provided, `autocreate_branch_source_branch` is ignored.

Type: `string`

Default: `null`

### <a name="input_branch"></a> [branch](#input\_branch)

Description: Git branch (defaults to the repository's default branch).   
The branch must already exist, it will only be created automatically if `autocreate_branch` is set to true.

Type: `string`

Default: `null`

### <a name="input_commit_author"></a> [commit\_author](#input\_commit\_author)

Description: Committer author name to use.   
NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App.   
This may be useful when a branch protection rule requires signed commits.

Type: `string`

Default: `null`

### <a name="input_commit_email"></a> [commit\_email](#input\_commit\_email)

Description: Committer email address to use.   
NOTE: GitHub app users may omit author and email information so GitHub can verify commits as the GitHub App.   
This may be useful when a branch protection rule requires signed commits.

Type: `string`

Default: `null`

### <a name="input_commit_message"></a> [commit\_message](#input\_commit\_message)

Description: The commit message when creating, updating or deleting the managed file.

Type: `string`

Default: `null`

### <a name="input_overwrite_on_create"></a> [overwrite\_on\_create](#input\_overwrite\_on\_create)

Description: Enable overwriting existing files. If set to true it will overwrite an existing file with the same name.   
If set to false it will fail if there is an existing file with the same name.

Type: `bool`

Default: `false`

## Outputs

No outputs.

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->