terraform {
  required_version = "~> 1.9"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.5"
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

# Example 1: Restrictive configuration - only local actions allowed
module "github_repository_local_only" {
  source = "../../"

  name                 = "${random_pet.repo_name.id}-local-only"
  organization_name    = var.github_organization_name
  visibility           = "private"
  vulnerability_alerts = false
  archive_on_destroy   = false

  actions_permissions = {
    allowed_actions = "local_only"
    enabled         = true
  }
}

# Example 2: Allowlist configuration - selected actions only
module "github_repository_selected" {
  source = "../../"

  name                 = "${random_pet.repo_name.id}-selected"
  organization_name    = var.github_organization_name
  visibility           = "private"
  vulnerability_alerts = false
  archive_on_destroy   = false

  actions_permissions = {
    allowed_actions = "selected"
    enabled         = true
    allowed_actions_config = {
      github_owned_allowed = true
      verified_allowed     = false
      patterns_allowed = [
        "docker/*",
        "azure/webapps-deploy@v2",
        "hashicorp/setup-terraform@v3"
      ]
    }
  }
}

# Example 3: All actions allowed (default behavior, least restrictive)
module "github_repository_all_actions" {
  source = "../../"

  name                 = "${random_pet.repo_name.id}-all-actions"
  organization_name    = var.github_organization_name
  visibility           = "private"
  vulnerability_alerts = false
  archive_on_destroy   = false

  actions_permissions = {
    allowed_actions = "all"
    enabled         = true
  }
}
