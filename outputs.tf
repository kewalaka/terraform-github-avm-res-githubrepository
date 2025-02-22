# output "actions_variables" {
#   value = github_actions_variable.default
# }

output "admins" {
  value = github_team_repository.admin
}

output "branch_protection" {
  value = github_branch_protection.this
}

output "maintainers" {
  value = github_team_repository.maintain
}

output "pullers" {
  value = github_team_repository.pull
}

output "pushers" {
  value = github_team_repository.push
}

output "repository" {
  value = github_repository.this
}
