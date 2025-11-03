variable "secrets" {
  type = map(object({
    name                 = string
    plaintext_value      = optional(string)
    encrypted_value      = optional(string)
    environment          = optional(string)
    is_dependabot_secret = optional(bool, false)
    is_codespaces_secret = optional(bool, false)
  }))
  default     = {}
  description = <<DESCRIPTION
Map of github action secrets to be created.

- `name` - The name of the secret.
- `plaintext_value` - The plaintext value of the secret.
- `encrypted_value` - The encrypted value of the secret.
- `environment` - The environment to create the secret in. If not set, the secret will be created at the repository level.
- `is_dependabot_secret` - If set to true, the secret will be created at the repository level and will be used by dependabot.
- `is_codespaces_secret` - If set to true, the secret will be created at the repository level and will be used by codespaces.

DESCRIPTION
  nullable    = false

  validation {
    condition = alltrue([
      for secret in var.secrets : (
        secret.environment == null
        ||
        (
          (secret.is_dependabot_secret == false || secret.is_dependabot_secret == null)
          &&
          (secret.is_codespaces_secret == false || secret.is_codespaces_secret == null)
        )
      )
    ])
    error_message = "If `is_dependabot_secret` or `is_codespaces_secret` is set, then `environment` must be unset, as these are repository level secrets."
  }
  validation {
    condition = alltrue([
      for secret in var.secrets : (
        secret.is_dependabot_secret == false || secret.is_dependabot_secret == null
        ||
        secret.is_codespaces_secret == false || secret.is_codespaces_secret == null
      )
    ])
    error_message = "Only one of `is_dependabot_secret` or `is_codespaces_secret` can be set per secret."
  }
}

variable "variables" {
  type = map(object({
    name        = string
    value       = string
    environment = optional(string)
  }))
  default     = {}
  description = <<DESCRIPTION
Map of github action variables to be created.

- `name` - The name of the variable.
- `value` - The value of the variable.
- `environment` - The environment to create the variable in. If not set, the variable will be created at the repository level.

DESCRIPTION
  nullable    = false
}
