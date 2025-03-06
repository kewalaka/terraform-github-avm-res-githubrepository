locals {
  enable_github_advanced_security = var.github_advanced_security.enable_advanced_security || var.github_advanced_security.enable_secret_scanning || var.github_advanced_security.enable_secret_scanning_push_protection
  free_plan                       = data.github_organization.this.plan == "free"
}

