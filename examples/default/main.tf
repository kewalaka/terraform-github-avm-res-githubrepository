terraform {
  required_version = "~> 1.9"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.7"
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

module "github_repository" {
  source = "../../"

  name                 = random_pet.repo_name.id
  organization_name    = var.github_organization_name
  archive_on_destroy   = false
  visibility           = "private"
  vulnerability_alerts = false
}
