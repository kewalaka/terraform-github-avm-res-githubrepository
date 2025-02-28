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

variable "value" {
  type        = string
  description = "The plaintext value of the secret."
  nullable    = false
}

variable "environment" {
  type        = string
  default     = null
  description = "The environment to create the secret in. If not set, the secret will be created at the repository level."
}
