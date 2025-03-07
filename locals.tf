locals {
  enable_github_advanced_security = local.free_plan_visibility_notpublic ? false : var.github_advanced_security.enable_advanced_security || var.github_advanced_security.enable_secret_scanning || var.github_advanced_security.enable_secret_scanning_push_protection || var.visibility == "public"
  free_plan                       = data.github_organization.this.plan == "free"
  free_plan_visibility_notpublic  = local.free_plan && var.visibility != "public"
  has_wiki                        = local.free_plan_visibility_notpublic ? false : var.has_wiki
}
