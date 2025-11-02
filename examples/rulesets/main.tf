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

  name               = random_pet.repo_name.id
  organization_name  = var.github_organization_name
  archive_on_destroy = false
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
  visibility           = "public"
  vulnerability_alerts = false
}



