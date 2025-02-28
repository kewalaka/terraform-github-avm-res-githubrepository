locals {
  secret_type = (
    var.environment != null ? "environment" :
    var.is_dependabot_secret ? "dependabot" :
    var.is_codespaces_secret ? "codespaces" :
    "repository"
  )
}
