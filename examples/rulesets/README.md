<!-- BEGIN_TF_DOCS -->
# GitHub repository with rulesets

This example demonstrates the use of repository rulesets to enforce policies on branches, tags, and pushes.

Rulesets are the newer way to protect branches and tags, offering more flexibility than classic branch protection policies.

This example shows:
- Branch protection rulesets for `main` and `release/*` branches
- Tag protection rulesets for semantic versioning
- Using evaluate mode for testing before enforcement
- Multiple rule types: pull requests, status checks, signed commits, linear history, and more

GitHub App permissions required:

- Repository Administration: write

Note: Rulesets require the repository to exist first. This example creates a new repository with rulesets applied.

ref: <https://docs.github.com/en/rest/repos/rules>

```hcl
terraform {
  required_version = "~> 1.9"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "github" {
  owner = var.github_organization_name
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_pem_file
  }
}

resource "random_pet" "repo_name" {
  length = 2
}

# Create a repository with comprehensive rulesets
module "github_repository" {
  source = "../../"

  name                 = random_pet.repo_name.id
  organization_name    = var.github_organization_name
  visibility           = "public"
  vulnerability_alerts = false
  archive_on_destroy   = false

  # Create a dev branch for testing
  branches = {
    "dev" = {
      name          = "dev"
      source_branch = "main"
    }
    "release" = {
      name          = "release"
      source_branch = "main"
    }
  }

  # Define rulesets for branch, tag, and push protection
  rulesets = {
    # Main branch protection
    main_protection = {
      name        = "main-branch-protection"
      target      = "branch"
      enforcement = "active"

      conditions = {
        ref_name = {
          include = ["refs/heads/main"]
          exclude = []
        }
      }

      rules = {
        # Require pull requests with reviews
        pull_request = {
          required_approving_review_count   = 2
          require_code_owner_review         = true
          required_review_thread_resolution = true
          require_last_push_approval        = true
        }

        # Require status checks
        required_status_checks = {
          required_check = [
            {
              context = "ci/tests"
            }
          ]
          strict_required_status_checks_policy = true
        }

        # Require signed commits and linear history
        required_signatures     = true
        required_linear_history = true

        # Block deletions and non-fast-forward pushes
        deletion         = true
        non_fast_forward = true
      }
    }

    # Release branch protection
    release_protection = {
      name        = "release-branch-protection"
      target      = "branch"
      enforcement = "active"

      conditions = {
        ref_name = {
          include = ["refs/heads/release/*"]
          exclude = []
        }
      }

      rules = {
        pull_request = {
          required_approving_review_count = 1
          require_code_owner_review       = true
        }

        required_signatures     = true
        required_linear_history = true
        deletion                = true
        non_fast_forward        = true
      }
    }

    # Tag protection for version tags
    tag_protection = {
      name        = "semantic-version-tags"
      target      = "tag"
      enforcement = "active"

      conditions = {
        ref_name = {
          include = ["refs/tags/v*"]
          exclude = []
        }
      }

      rules = {
        # Block creation, deletion, and updates of tags
        creation = true
        deletion = true
        update   = true

        # Enforce semantic versioning pattern
        tag_name_pattern = {
          operator = "regex"
          pattern  = "^v[0-9]+\\.[0-9]+\\.[0-9]+$"
          name     = "Semantic Versioning"
          negate   = false
        }
      }
    }

    # Dev branch - more lenient rules
    dev_protection = {
      name        = "dev-branch-protection"
      target      = "branch"
      enforcement = "evaluate" # Start in evaluate mode

      conditions = {
        ref_name = {
          include = ["refs/heads/dev"]
          exclude = []
        }
      }

      rules = {
        pull_request = {
          required_approving_review_count = 1
        }
      }
    }
  }
}

# Output the created rulesets
output "repository_name" {
  description = "The name of the created repository"
  value       = module.github_repository.repository.name
}

output "repository_url" {
  description = "The URL of the created repository"
  value       = module.github_repository.repository.html_url
}

output "rulesets" {
  description = "The rulesets applied to the repository"
  value       = module.github_repository.rulesets
  sensitive   = false
}
```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.9)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

<!-- markdownlint-disable MD013 -->
## Resources

The following resources are used by this module:

- [random_pet.repo_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name)

Description: The name of the GitHub organization

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id)

Description: The GitHub App ID for authentication

Type: `string`

Default: `""`

### <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id)

Description: The GitHub App installation ID for authentication

Type: `string`

Default: `""`

### <a name="input_github_app_pem_file"></a> [github\_app\_pem\_file](#input\_github\_app\_pem\_file)

Description: The path to the GitHub App PEM file for authentication

Type: `string`

Default: `""`

## Outputs

The following outputs are exported:

### <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name)

Description: The name of the created repository

### <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url)

Description: The URL of the created repository

### <a name="output_rulesets"></a> [rulesets](#output\_rulesets)

Description: The rulesets applied to the repository

## Modules

The following Modules are called:

### <a name="module_github_repository"></a> [github\_repository](#module\_github\_repository)

Source: ../../

Version:

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft's privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->