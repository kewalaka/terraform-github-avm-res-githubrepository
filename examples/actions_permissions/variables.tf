variable "github_organization_name" {
  type        = string
  description = "The GitHub organization name."
}

variable "github_app_id" {
  type        = string
  description = "The GitHub App ID for authentication."
}

variable "github_app_installation_id" {
  type        = string
  description = "The GitHub App installation ID for authentication."
}

variable "github_app_pem_file" {
  type        = string
  description = "The path to the GitHub App PEM file for authentication."
}
