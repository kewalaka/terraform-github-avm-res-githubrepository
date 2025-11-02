variable "actions_permissions" {
  type = object({
    allowed_actions = optional(string, "all")
    enabled         = optional(bool, true)
    allowed_actions_config = optional(object({
      github_owned_allowed = bool
      patterns_allowed     = list(string)
      verified_allowed     = optional(bool)
    }))
  })
  default     = null
  description = <<DESCRIPTION
Configuration for GitHub Actions repository permissions. Controls which actions are allowed to run in the repository.

- `allowed_actions` - (Optional) The type of actions that are allowed. Possible values are `all`, `local_only`, or `selected`. Defaults to `all`.
- `enabled` - (Optional) Whether GitHub Actions is enabled on the repository. Defaults to `true`.
- `allowed_actions_config` - (Optional) Configuration for which actions are allowed when `allowed_actions` is set to `selected`.
  - `github_owned_allowed` - Whether GitHub-owned actions are allowed (e.g., actions from the `actions` organization).
  - `patterns_allowed` - List of string-matching patterns to allow specific action(s). Wildcards, tags, and SHAs are allowed. For example, `monalisa/octocat@*`, `monalisa/octocat@v2`, `monalisa/*`.
  - `verified_allowed` - (Optional) Whether actions from GitHub Marketplace verified creators are allowed.

## Supply Chain Security

This provides critical supply-chain and CI governance controls:
- Use `local_only` to restrict to actions defined in your repository only (most secure)
- Use `selected` with allowlists to permit specific trusted actions
- Use `all` for maximum flexibility (default, but highest risk)

## Examples

### Restrictive (local actions only):
```terraform
actions_permissions = {
  allowed_actions = "local_only"
  enabled         = true
}
```

### Allowlist (selected actions):
```terraform
actions_permissions = {
  allowed_actions = "selected"
  enabled         = true
  allowed_actions_config = {
    github_owned_allowed = true
    verified_allowed     = false
    patterns_allowed     = ["docker/*", "azure/webapps-deploy@v2"]
  }
}
```
DESCRIPTION
}
