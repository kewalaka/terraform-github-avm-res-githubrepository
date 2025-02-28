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
  secrets = {
    repo1 = {
      name            = "REPO_SECRET_1"
      plaintext_value = "supersecretvalue"
    }
    env1 = {
      name            = "ENV_SECRET_1"
      plaintext_value = "anothersecretvalue"
      environment     = "production"
    }
  }
}

module "avm_res_githubrepository_secret" {
  source  = "Azure/avm-res-githubrepository/github//modules/secret"
  version = "x.y.z"

  for_each = local.secrets

  repository = { id = github_repository.this.id }

  name            = each.value.name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
  environment     = each.value.environmnet
}
```
