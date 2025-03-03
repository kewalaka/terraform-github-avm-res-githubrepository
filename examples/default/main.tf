terraform {
  required_version = "~> 1.9"
  required_providers {
    # github = {
    #   source  = "integrations/github"
    #   version = "~> 6.5.0"
    # }
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

resource "random_pet" "repo_name" {
  length = 2
}

module "github_repository" {
  source = "../../"

  name                 = random_pet.repo_name.id
  organization_name    = "kewalaka-org"
  visibility           = "private"
  vulnerability_alerts = false
  archive_on_destroy   = false
}
