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
