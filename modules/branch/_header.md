# Github Repository Branch Submodule

This module is used to managed branches inside Github repositories.

## Features

Create a branch, optionally supplying a branch or commit SHA as the source.

Branch protection policies are created in separately in the `branch_protection` submodule, because they may apply to a pattern (e.g. *releases*) rather than a singular branch.

## Usage

TODO

```terraform
module "avm-res-githubrepository-branch" {
  source = "Azure/avm-res-githubrepository/github//modules/branch"


}
```
