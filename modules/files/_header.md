# Github Repository Files Submodule

This module is used to manage files contents inside a repository

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
