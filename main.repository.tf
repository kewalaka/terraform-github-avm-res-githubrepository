data "github_organization" "this" {
  name         = var.organization_name
  summary_only = true
}

resource "github_repository" "this" {
  name                 = var.name
  description          = join(" • ", [var.description, "This repository is defined and managed in Terraform"])
  auto_init            = true
  visibility           = var.visibility #data.github_organization.this.plan == local.free_plan ? "public" : "private"
  allow_update_branch  = true
  allow_merge_commit   = false
  allow_rebase_merge   = false
  has_discussions      = var.has_discussions
  has_downloads        = var.has_downloads
  has_projects         = var.has_projects
  has_wiki             = var.has_wiki
  has_issues           = var.has_issues
  is_template          = var.type == "template" ? true : false
  homepage_url         = var.homepage_url
  archived             = false
  archive_on_destroy   = var.archive_on_destroy
  topics               = var.topics
  vulnerability_alerts = var.vulnerability_alerts

  dynamic "security_and_analysis" {
    for_each = local.enable_github_advanced_security ? [1] : []
    content {
      dynamic "advanced_security" {
        for_each = var.github_advanced_security.enable_advanced_security ? [1] : []
        content {
          status = "enabled"
        }
      }
      secret_scanning {
        status = var.github_advanced_security.enable_secret_scanning ? "enabled" : "disabled"
      }
      secret_scanning_push_protection {
        status = var.github_advanced_security.enable_secret_scanning_push_protection ? "enabled" : "disabled"
      }
    }
  }

  dynamic "template" {
    for_each = var.use_template_repository ? [true] : []
    content {
      owner                = var.template.owner
      repository           = var.template.repository
      include_all_branches = false
    }
  }

  dynamic "pages" {
    for_each = var.pages != null ? [true] : []

    content {
      source {
        branch = var.pages.branch
        path   = try(var.pages.path, "/")
      }
      cname = try(var.pages.cname, null)
    }
  }

  # The `pages.source` block doesn't support dynamic blocks in GitHub provider version 4.3.2,
  # so we ignore the changes so it doesn't try to revert repositories that have manually set
  # their pages configuration.
  lifecycle {
    ignore_changes = [template, pages]
  }
}

# roles
resource "github_team_repository" "admin" {
  for_each = var.team_access != null && var.team_access.admin != null ? { for team in var.team_access.admin : team => team } : {}

  team_id    = each.value
  repository = github_repository.this.name
  permission = "admin"
}

resource "github_team_repository" "maintain" {
  for_each = var.team_access != null && var.team_access.maintain != null ? { for team in var.team_access.maintain : team => team } : {}

  team_id    = each.value
  repository = github_repository.this.name
  permission = "maintain"
}

resource "github_team_repository" "push" {
  for_each = var.team_access != null && var.team_access.push != null ? { for team in var.team_access.push : team => team } : {}

  team_id    = each.value
  repository = github_repository.this.name
  permission = "push"
}

resource "github_team_repository" "pull" {
  for_each = var.team_access != null && var.team_access.pull != null ? { for team in var.team_access.pull : team => team } : {}

  team_id    = each.value
  repository = github_repository.this.name
  permission = "pull"
}

# repo contents
# resource "github_repository_file" "this" {
#   for_each            = var.repository_files
#   repository          = github_repository.this.name
#   file                = each.key
#   content             = each.value.content
#   commit_author       = local.default_commit_email
#   commit_email        = local.default_commit_email
#   commit_message      = "Add ${each.key} [skip ci]"
#   overwrite_on_create = true
# }
