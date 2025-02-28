resource "github_actions_secret" "this" {
  count           = local.secret_type == "repository" ? 1 : 0
  repository      = var.repository.id
  secret_name     = var.name
  plaintext_value = var.plaintext_value
  encrypted_value = var.encrypted_value
}

resource "github_actions_environment_secret" "this" {
  count           = local.secret_type == "environment" ? 1 : 0
  repository      = var.repository.id
  secret_name     = var.name
  plaintext_value = var.plaintext_value
  encrypted_value = var.encrypted_value
  environment     = var.environment
}

resource "github_dependabot_secret" "this" {
  count           = local.secret_type == "dependabot" ? 1 : 0
  repository      = var.repository.id
  secret_name     = var.name
  plaintext_value = var.plaintext_value
  encrypted_value = var.encrypted_value
}

resource "github_codespaces_secret" "this" {
  count           = local.secret_type == "codespaces" ? 1 : 0
  repository      = var.repository.id
  secret_name     = var.name
  plaintext_value = var.plaintext_value
  encrypted_value = var.encrypted_value
}
