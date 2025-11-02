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

# Create a repository externally (simulating an existing repo)
resource "random_pet" "repo_name" {
  length = 2
}

resource "github_repository" "external" {
  name                 = random_pet.repo_name.id
  visibility           = "public"
  archive_on_destroy   = false
  vulnerability_alerts = true
  auto_init            = true
}

# Example 1: Using the module with an existing repository
# Note: Branch protection is skipped because repository_node_id is not provided
module "existing_repo_without_node_id" {
  source = "../../"

  name                    = github_repository.external.name
  organization_name       = var.github_organization_name
  use_existing_repository = true
  enable_telemetry        = false

  # These subcomponents will be configured on the existing repository
  environments = {
    production = {
      name = "production"
      deployment_branch_policy = {
        protected_branches     = true
        custom_branch_policies = false
      }
    }
  }

  secrets = {
    repo_secret = {
      name            = "REPO_SECRET_1"
      plaintext_value = "supersecretvalue"
    }
    env_secret = {
      name            = "ENV_SECRET_1"
      plaintext_value = "anothersecretvalue"
      environment     = "production"
    }
  }

  variables = {
    repo_var = {
      name  = "REPO_VAR_1"
      value = "repo_value"
    }
  }

  # Branch protection will be skipped (check module output for warning)
  branch_protection_policies = {}
}

# Example 2: Using the module with an existing repository AND node_id for branch protection
module "existing_repo_with_node_id" {
  source = "../../"

  name                    = github_repository.external.name
  organization_name       = var.github_organization_name
  use_existing_repository = true
  repository_node_id      = github_repository.external.node_id
  enable_telemetry        = false

  # Branch protection can be configured when repository_node_id is provided
  branch_protection_policies = {
    main_protection = {
      pattern        = "main"
      enforce_admins = true
      required_pull_request_reviews = {
        required_approving_review_count = 1
        restrict_dismissals             = false
      }
    }
  }
}

# Output warnings if branch protection is skipped
output "branch_protection_warning_example1" {
  description = "Warning from example 1 (without node_id)"
  value       = module.existing_repo_without_node_id.branch_protection_warning
}

output "branch_protection_warning_example2" {
  description = "Warning from example 2 (with node_id)"
  value       = module.existing_repo_with_node_id.branch_protection_warning
}

output "repository_name" {
  description = "The name of the managed repository"
  value       = module.existing_repo_without_node_id.repository_name
}
