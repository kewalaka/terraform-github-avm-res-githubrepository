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

  name               = random_pet.repo_name.id
  organization_name  = "kewalaka-org"
  visibility         = "public"
  archive_on_destroy = false

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
