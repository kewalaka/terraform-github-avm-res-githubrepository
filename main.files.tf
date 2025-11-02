module "file" {
  source = "./modules/file"

  for_each = var.files

  repository = {
    id = local.repository_id
  }

  content                         = each.value.content
  file                            = each.value.file
  branch                          = each.value.branch
  commit_message                  = each.value.commit_message
  commit_author                   = each.value.commit_author
  commit_email                    = each.value.commit_email
  overwrite_on_create             = each.value.overwrite_on_create
  autocreate_branch               = each.value.autocreate_branch
  autocreate_branch_source_branch = each.value.autocreate_branch_source_branch
  autocreate_branch_source_sha    = each.value.autocreate_branch_source_sha
}
