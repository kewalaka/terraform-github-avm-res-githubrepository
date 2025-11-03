terraform {
  required_version = "~> 1.9"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.7.0"
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

resource "github_repository" "this" {
  name                 = random_pet.repo_name.id
  visibility           = "public"
  archive_on_destroy   = false
  vulnerability_alerts = true
}

locals {
  secrets = {
    repo1 = {
      name            = "REPO_SECRET_1"
      plaintext_value = "supersecretvalue"
    }
    env1 = {
      name            = "ENV_SECRET_1"
      plaintext_value = "anothersecretvalue"
      environment     = "production"
    }
  }
}

module "avm_res_githubrepository_secret" {
  source   = "../..//modules/secret"
  for_each = local.secrets

  name            = each.value.name
  repository      = { id = github_repository.this.id }
  encrypted_value = try(each.value.encrypted_value, null)
  environment     = try(each.value.environmnet, null)
  plaintext_value = try(each.value.plaintext_value, null)
}
