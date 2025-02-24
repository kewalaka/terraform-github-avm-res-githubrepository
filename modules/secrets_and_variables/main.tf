# repository level
resource "github_actions_secret" "secrets" {
  for_each = local.repository_secrets

  repository      = var.repository.id
  secret_name     = each.value.name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
}

resource "github_actions_variable" "variables" {
  for_each = local.repository_variables

  repository    = var.repository.id
  variable_name = each.value.name
  value         = each.value.value
}

# environments
resource "github_actions_environment_secret" "environment_secrets" {
  for_each = local.environment_secrets

  repository      = var.repository.id
  secret_name     = each.value.name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
  environment     = each.value.environment
}

resource "github_actions_environment_variable" "environment_variables" {
  for_each = local.environment_variables

  repository    = var.repository.id
  variable_name = each.value.name
  value         = each.value.value
  environment   = each.value.environment
}

# dependabot and codespaces
resource "github_dependabot_secret" "dependabot_secrets" {
  for_each = local.dependabot_secrets

  repository      = var.repository.id
  secret_name     = each.value.name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
}

resource "github_codespaces_secret" "codespaces_secrets" {
  for_each = local.codespaces_secrets

  repository      = var.repository.id
  secret_name     = each.value.name
  plaintext_value = each.value.plaintext_value
  encrypted_value = each.value.encrypted_value
}
