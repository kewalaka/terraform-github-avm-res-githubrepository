# map of github action secrets and variables to be created
variable "repository_secrets" {
  type        = map(string)
  description = <<DESCRIPTION
Map of github action secrets to be created.
DESCRIPTION
  default     = {}
  nullable    = false
}

variable "repository_variables" {
  type        = map(string)
  description = <<DESCRIPTION
Map of github action variables to be created.
DESCRIPTION
  default     = {}
  nullable    = false
}
