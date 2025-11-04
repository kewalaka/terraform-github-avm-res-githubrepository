# variable "required_checks" {
#   type        = list(string)
#   description = "List of required checks"
#   default     = []
# }

variable "archive_on_destroy" {
  type        = bool
  default     = true
  description = "Archive repository instead of deleting it on destroy"
}

variable "description" {
  type        = string
  default     = ""
  description = <<DESCRIPTION
The description of the repository.
DESCRIPTION
  nullable    = false
}

variable "has_discussions" {
  type        = bool
  default     = true
  description = "Enable repository discussions"
  nullable    = false
}

variable "has_downloads" {
  type        = bool
  default     = true
  description = "Enable repository downloads"
  nullable    = false
}

variable "has_issues" {
  type        = bool
  default     = true
  description = "Enable repository issues"
  nullable    = false
}

variable "has_projects" {
  type        = bool
  default     = false
  description = "Enable repository projects"
  nullable    = false
}

variable "has_wiki" {
  type        = bool
  default     = true
  description = "Enable repository wiki"
  nullable    = false
}

variable "homepage_url" {
  type        = string
  default     = ""
  description = "Repository homepage URL"
}

variable "pages" {
  type = object({
    branch = string
    path   = string
    cname  = string
  })
  default     = null
  description = "The GitHub Pages configuration for the repository."
}

variable "team_access" {
  type = object({
    admin    = optional(list(string))
    maintain = optional(list(string))
    push     = optional(list(string))
    pull     = optional(list(string))
    triage   = optional(list(string))
  })
  default     = {}
  description = "Team access types for created repository"
}

variable "topics" {
  type        = list(string)
  default     = []
  description = "values to use as topics for the repository"
}

variable "type" {
  type        = string
  default     = "core"
  description = "Type of repository: `core`, `module`, `template`. Defaults to `core`"
}

variable "visibility" {
  type        = string
  default     = "internal"
  description = <<DESCRIPTION
The visibility of the repository.  Can be "public", "internal", or "private".

Only organizations associated with an enterprise can set visibility to internal 

DESCRIPTION

  validation {
    condition     = can(regex("^(public|internal|private)$", var.visibility))
    error_message = "Invalid visibility.  Must be 'public', 'internal', or 'private'."
  }
}

variable "vulnerability_alerts" {
  type        = bool
  default     = true
  description = "Enable vulnerability alerts"
  nullable    = false
}

variable "actions_oidc_subject_claim_customization_template" {
  type = object({
    use_default        = bool
    include_claim_keys = optional(list(string))
  })
  default     = null
  description = <<DESCRIPTION
Configuration for GitHub Actions OIDC subject claim customization template for this repository.

- `use_default`: If true, use the default template. When true, `include_claim_keys` must be null or omitted.
- `include_claim_keys`: Optional list of OpenID Connect claim keys to include in the subject claim. Valid keys include: `repo`, `context`, `job_workflow_ref`, `repository_id`, `repository_owner_id`, `runner_environment`, `environment`, `event_name`, `ref`, `sha`, `workflow`, etc. When `use_default` is false and this is not set, the repository will inherit the organization template if present, otherwise use GitHub defaults.

Set to `null` (default) to not manage the OIDC template for this repository.

Example for using default:
```hcl
actions_oidc_subject_claim_customization_template = {
  use_default = true
}
```

Example for custom claim keys:
```hcl
actions_oidc_subject_claim_customization_template = {
  use_default = false
  include_claim_keys = ["repo", "context", "job_workflow_ref"]
}
```
DESCRIPTION

  validation {
    condition = var.actions_oidc_subject_claim_customization_template == null ? true : (
      var.actions_oidc_subject_claim_customization_template.use_default == false ||
      var.actions_oidc_subject_claim_customization_template.include_claim_keys == null
    )
    error_message = "When use_default is true, include_claim_keys must be null or omitted."
  }
}
