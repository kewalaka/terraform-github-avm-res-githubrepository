variable "description" {
  type        = string
  description = <<DESCRIPTION
The description of the repository.
DESCRIPTION
  nullable    = false
  default     = ""
}

variable "visibility" {
  type        = string
  description = <<DESCRIPTION
The visibility of the repository.  Can be "public", "internal", or "private".

Only organizations associated with an enterprise can set visibility to internal 

DESCRIPTION
  default     = "internal"
  validation {
    condition     = can(regex("^(public|internal|private)$", var.visibility))
    error_message = "Invalid visibility.  Must be 'public', 'internal', or 'private'."
  }
}

# variable "required_checks" {
#   type        = list(string)
#   description = "List of required checks"
#   default     = []
# }

variable "has_discussions" {
  type        = bool
  description = "Enable repository discussions"
  default     = true
  nullable    = false
}

variable "has_downloads" {
  type        = bool
  description = "Enable repository downloads"
  default     = true
  nullable    = false
}

variable "has_projects" {
  type        = bool
  description = "Enable repository projects"
  default     = false
  nullable    = false
}

variable "has_wiki" {
  type        = bool
  description = "Enable repository wiki"
  default     = true
  nullable    = false
}

variable "has_issues" {
  type        = bool
  description = "Enable repository issues"
  default     = true
  nullable    = false
}

variable "team_access" {
  type = object({
    admin    = optional(list(string))
    maintain = optional(list(string))
    push     = optional(list(string))
    pull     = optional(list(string))
    triage   = optional(list(string))
  })
  description = "Team access types for created repository"
  default     = {}
}

variable "archive_on_destroy" {
  type        = bool
  description = "Archive repository instead of deleting it on destroy"
  default     = true
}

variable "homepage_url" {
  type        = string
  description = "Repository homepage URL"
  default     = ""
}

variable "topics" {
  type        = list(string)
  description = "values to use as topics for the repository"
  default     = []
}

variable "type" {
  type        = string
  description = "Type of repository: `core`, `module`, `template`. Defaults to `core`"
  default     = "core"
}

variable "pages" {
  description = "The GitHub Pages configuration for the repository."
  type = object({
    branch = string
    path   = string
    cname  = string
  })
  default = null
}

variable "vulnerability_alerts" {
  type        = bool
  description = "Enable vulnerability alerts"
  default     = true
  nullable    = false
}
