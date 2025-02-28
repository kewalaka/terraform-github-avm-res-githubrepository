module "secret" {
  source = "./modules/secret"

  for_each = var.secrets

  repository = {
    id = github_repository.this.id
  }

  name                 = each.value.name
  plaintext_value      = each.value.plaintext_value
  encrypted_value      = each.value.encrypted_value
  environment          = each.value.environment
  is_codespaces_secret = each.value.is_codespaces_secret
  is_dependabot_secret = each.value.is_dependabot_secret
}

module "variable" {
  source = "./modules/variable"

  for_each = var.variables

  repository = {
    id = github_repository.this.id
  }

  name        = each.value.name
  value       = each.value.value
  environment = each.value.environment
}
