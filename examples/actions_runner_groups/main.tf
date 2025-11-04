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

  # Configure GitHub Actions permissions
  actions_repository_permissions = {
    enabled         = true
    allowed_actions = "selected"
    allowed_actions_config = {
      github_owned_allowed = true
      patterns_allowed     = ["actions/*", "github/*"]
      verified_allowed     = true
    }
  }

  # Associate repository with runner groups
  # Note: Runner groups must be imported before first apply
  # terraform import 'module.github_repository.module.actions_runner_groups["production"].github_actions_runner_group.this' <runner_group_id>
  actions_runner_groups = {
    "production" = {
      name                       = "production-runners"
      restricted_to_workflows    = true
      selected_workflows         = [".github/workflows/deploy.yml", ".github/workflows/test.yml"]
      allows_public_repositories = false
      existing_repository_ids    = [] # Add IDs of other repos in this group if any
    }
  }
}
