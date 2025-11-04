variable "github_app_id" {
  type        = string
  description = "GitHub App ID for authentication"
}

variable "github_app_installation_id" {
  type        = string
  description = "GitHub App installation ID"
}

variable "github_app_pem_file" {
  type        = string
  description = "Path to GitHub App private key file"
}

variable "github_organization_name" {
  type        = string
  description = "GitHub organization name"
}
