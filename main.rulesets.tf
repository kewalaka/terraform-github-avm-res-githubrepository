module "rulesets" {
  source   = "./modules/ruleset"
  for_each = var.rulesets

  name = each.value.name
  repository = {
    id   = github_repository.this.id
    name = github_repository.this.name
  }

  target      = each.value.target
  enforcement = try(each.value.enforcement, "active")

  bypass_actors = try(each.value.bypass_actors, [])

  conditions = each.value.conditions

  rules = try(each.value.rules, {})

  depends_on = [
    module.branches
  ]
}
