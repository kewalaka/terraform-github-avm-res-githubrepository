variable "name" {
  type        = string
  description = "The name of the secret."
  nullable    = false
}

variable "repository" {
  type = object({
    id = string
  })
  description = "The id of the repository."
  nullable    = false
}

variable "encrypted_value" {
  type        = string
  default     = null
  description = "The encrypted value of the secret."
}

variable "environment" {
  type        = string
  default     = null
  description = "The environment to create the secret in. If not set, the secret will be created at the repository level."
}

variable "is_codespaces_secret" {
  type        = bool
  default     = false
  description = "If set to true, the secret will be created at the repository level and will be used by codespaces."
}

variable "is_dependabot_secret" {
  type        = bool
  default     = false
  description = "If set to true, the secret will be created at the repository level and will be used by dependabot."
}

variable "plaintext_value" {
  type        = string
  default     = null
  description = "The plaintext value of the secret."
}
