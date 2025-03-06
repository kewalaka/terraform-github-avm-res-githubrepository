<!-- BEGIN_TF_DOCS -->
# GitHub repository with environments and secrets

This deploys the module and has a starter for exercising environments & secrets.  TODO more coverage required.

```hcl
terraform {
  required_version = "~> 1.9"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.5.0"
    }
    # modtm = {
    #   source  = "azure/modtm"
    #   version = "~> 0.3"
    # }
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

data "github_user" "current" {
  username = "kewalaka"
}

module "github_repository" {
  source = "../../"

  name                 = random_pet.repo_name.id
  organization_name    = "kewalaka-org"
  visibility           = "public"
  vulnerability_alerts = false
  archive_on_destroy   = false

  environments = {
    "dev" = {
      name = "dev"
      reviewers = {
        users = [
          data.github_user.current.id,
        ]
      }
    }
  }

  secrets = {
    "deploy_secret" = {
      name      = "DEPLOY_SECRET"
      plaintext = "super_secret"
    }
  }

  variables = {
    "deploy_variable" = {
      name  = "DEPLOY_VARIABLE"
      value = "not_a_secret"
    }
  }

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
- [github_user.current](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/user) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id)

Description: The AppId of the GitHub App, used for authentication.

Type: `string`

### <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id)

Description: The installation id of the GitHub App, used for authentication.

Type: `string`

### <a name="input_github_app_pem_file"></a> [github\_app\_pem\_file](#input\_github\_app\_pem\_file)

Description: The contents of the PEM file for the GitHub App, used for authentication.

Type: `string`

### <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name)

Description: The name of the GitHub organization.

Type: `string`

## Optional Inputs

No optional inputs.

## Outputs

No outputs.

## Modules

The following Modules are called:

### <a name="module_github_repository"></a> [github\_repository](#module\_github\_repository)

Source: ../../

Version:

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->