# the pipeline supplies these via TF_VAR_<var_name>, if you're running this locally you'll need to set them:
# export TF_VAR_github_app_id="12345"
# export TF_VAR_github_app_installation_id="12345"
# export TF_VAR_github_app_pem_file=<contents of the PEM file>
# export TF_VAR_github_organization_name="my-github-org"
variable "github_app_id" {
  type        = string
  description = "The id of the GitHub App, used for authentication."
  nullable    = false
}

variable "github_app_installation_id" {
  type        = string
  description = "The installation id of the GitHub App, used for authentication."
  nullable    = false
}

variable "github_app_pem_file" {
  type        = string
  description = "The contents of the PEM file for the GitHub App, used for authentication."
  nullable    = false
}

variable "github_organization_name" {
  type        = string
  description = "The name of the GitHub organization."
  nullable    = false
}
