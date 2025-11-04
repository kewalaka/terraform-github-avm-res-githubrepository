module "rulesets" {
  source   = "./modules/ruleset"
  for_each = var.rulesets

  conditions = each.value.conditions
  name       = each.value.name
  repository = {
    id   = local.repository_id
    name = local.repository_name
  }
  target        = each.value.target
  bypass_actors = try(each.value.bypass_actors, [])
  enforcement   = try(each.value.enforcement, "active")
  rules         = try(each.value.rules, {})

  depends_on = [
    module.branches
  ]
}
