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

module "github_repository" {
  source = "../../"

  name                 = random_pet.repo_name.id
  organization_name    = "kewalaka-org"
  visibility           = "public"
  vulnerability_alerts = false
  archive_on_destroy   = false

  branches = {
    "dev" = {
      name          = "dev"
      source_branch = "main"
    }
  }

  branch_protection_policies = {
    main = {
      pattern        = "main"
      enforce_admins = true
    }
    dev = {
      pattern             = "dev"
      allows_force_pushes = true
    }
  }
}
