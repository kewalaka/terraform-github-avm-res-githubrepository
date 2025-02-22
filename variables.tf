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

variable "approvers" {
  type        = list(string)
  default     = []
  description = <<DESCRIPTION
A list of approvers.
DESCRIPTION
  nullable    = false
}

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

variable "environments" {
  type        = map(string)
  default     = {}
  description = <<DESCRIPTION
A map of environment names.
DESCRIPTION
  nullable    = false
}

variable "name_templates" {
  type        = string
  default     = null
  description = <<DESCRIPTION
The name of the templates repo to use.
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

variable "workflows" {
  type = map(object({
    workflow_file_name = string
    environment_user_assigned_managed_identity_mappings = list(object({
      environment_key                    = string
      user_assigned_managed_identity_key = string
    }))
  }))
  default     = {}
  description = <<DESCRIPTION
A map of workflows with their file names and environment user-assigned managed identity mappings.
DESCRIPTION
  nullable    = false
}
