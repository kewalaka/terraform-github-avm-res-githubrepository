# variable "approvers" {
#   type        = list(string)
#   default     = []
#   description = <<DESCRIPTION
# A list of approvers.
# DESCRIPTION
#   nullable    = false
# }

# variable "workflows" {
#   type = map(object({
#     workflow_file_name = string
#     environment_user_assigned_managed_identity_mappings = list(object({
#       environment_key                    = string
#       user_assigned_managed_identity_key = string
#     }))
#   }))
#   default     = {}
#   description = <<DESCRIPTION
# A map of workflows with their file names and environment user-assigned managed identity mappings.
# DESCRIPTION
#   nullable    = false
# }
variable "name" {
  type        = string
  description = <<DESCRIPTION
The name of this resource.
DESCRIPTION
  nullable    = false

  validation {
    condition     = can(regex("^[a-z0-9_.-]{1,100}$", var.name))
    error_message = "The name must be between 1 and 100 characters long and can only contain lowercase letters and numbers."
  }
}

variable "organization_name" {
  type        = string
  description = <<DESCRIPTION
The name of the organization.
DESCRIPTION
  nullable    = false
}

# tflint:ignore:variable-unused
variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
  nullable    = false
}

variable "github_advanced_security" {
  type = object({
    enable_advanced_security               = optional(bool)
    enable_secret_scanning                 = optional(bool)
    enable_secret_scanning_push_protection = optional(bool)
  })
  default = {
    enable_advanced_security               = true
    enable_secret_scanning                 = true
    enable_secret_scanning_push_protection = true
  }
  description = <<DESCRIPTION
Options for configuring security and analysis features.

- `enable_advanced_security` - Whether to enable advanced security features.
- `enable_secret_scanning` - Whether to enable secret scanning.
- `enable_secret_scanning_push_protection` - Whether to enable secret scanning push protection.
DESCRIPTION
}

variable "template" {
  type = object({
    owner                = optional(string)
    repository           = optional(string)
    include_all_branches = optional(bool, false)
  })
  default     = {}
  description = <<DESCRIPTION
The template repository to use when creating the repository.

- `owner` (Optional) - The owner of the template repository.
- `repository` (Optional) - The name of the template repository.
- `include_all_branches` (Optional) - Whether to include all branches from the template repository.

DESCRIPTION
}

variable "use_template_repository" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
Whether to use the template repository.
DESCRIPTION
  nullable    = false
}
