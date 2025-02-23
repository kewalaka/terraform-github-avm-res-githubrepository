# create a map of environments to be created along with their associated github action secrets and variables
variable "environments" {
  type = map(object({
    name      = string
    secrets   = map(string)
    variables = map(string)
  }))
  description = <<DESCRIPTION
Map of environments to be created along with their associated github action secrets and variables.
DESCRIPTION
  default     = {}
  nullable    = false
}

