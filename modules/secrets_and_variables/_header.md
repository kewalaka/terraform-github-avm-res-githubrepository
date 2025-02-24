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
