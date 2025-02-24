module "secrets_and_variables" {
  source = "./modules/secrets_and_variables"

  repository = {
    id = github_repository.this.id
  }

  secrets   = var.secrets
  variables = var.variables
}
