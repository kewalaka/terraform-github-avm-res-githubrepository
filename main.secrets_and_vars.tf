module "secret" {
  source   = "./modules/secret"
  for_each = var.secrets

  name = each.value.name
  repository = {
    id = local.repository_id
  }
  encrypted_value      = each.value.encrypted_value
  environment          = each.value.environment
  is_codespaces_secret = each.value.is_codespaces_secret
  is_dependabot_secret = each.value.is_dependabot_secret
  plaintext_value      = each.value.plaintext_value
}

module "variable" {
  source   = "./modules/variable"
  for_each = var.variables

  name = each.value.name
  repository = {
    id = local.repository_id
  }
  value       = each.value.value
  environment = each.value.environment
}
