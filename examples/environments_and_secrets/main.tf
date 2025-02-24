terraform {
  required_version = "~> 1.9"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.5.0"
    }
    modtm = {
      source  = "azure/modtm"
      version = "~> 0.3"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

resource "random_pet" "repo_name" {
  length = 2
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
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
          "kewalaka",
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
