module "rulesets" {
  source   = "./modules/ruleset"
  for_each = var.rulesets

  conditions = each.value.conditions
  name       = each.value.name
  repository = {
    id   = github_repository.this.id
    name = github_repository.this.name
  }
  target        = each.value.target
  bypass_actors = try(each.value.bypass_actors, [])
  enforcement   = try(each.value.enforcement, "active")
  rules         = try(each.value.rules, {})

  depends_on = [
    module.branches
  ]
}
