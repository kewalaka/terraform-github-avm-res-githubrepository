locals {
  codespaces_secrets = {
    for key, value in var.secrets : key => value
    if value.environment == null && value.is_dependabot_secret == null && value.is_codespaces_secret != null
  }
  dependabot_secrets = {
    for key, value in var.secrets : key => value
    if value.environment == null && value.is_dependabot_secret != null && value.is_codespaces_secret == null
  }
  environment_secrets = {
    for key, value in var.secrets : key => value
    if value.environment != null && value.is_dependabot_secret == null && value.is_codespaces_secret == null
  }
  environment_variables = {
    for key, value in var.variables : key => value
    if value.environment != null
  }
  repository_secrets = {
    for key, value in var.secrets : key => value
    if value.environment == null && value.is_dependabot_secret == null && value.is_codespaces_secret == null
  }
  repository_variables = {
    for key, value in var.variables : key => value
    if value.environment == null
  }
}
