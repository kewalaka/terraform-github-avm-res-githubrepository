<!-- BEGIN_TF_DOCS -->
# Github Repository Ruleset Submodule

This module is used to manage repository rulesets in GitHub repositories. Rulesets are the newer way to enforce branch protection, tag protection, and other repository policies.

## Features

- Create and manage repository rulesets
- Support for branch, tag, and push targets
- Comprehensive rule configuration including:
  - Pull request requirements (approvals, code owner reviews, conversation resolution)
  - Required status checks
  - Commit signing and linear history requirements
  - Protection against force pushes and deletions
  - Commit message and author email patterns
  - Tag name patterns
  - Required workflows
- Bypass actors configuration for users, teams, and apps

## Usage

### Branch Protection Ruleset

```terraform
module "main_branch_ruleset" {
  source = "kewalaka/avm-res-githubrepository/github//modules/ruleset"
  # For local development: source = "./modules/ruleset"

  name       = "main-branch-protection"
  repository = {
    id   = "repo-id"
    name = "my-repository"
  }
  target     = "branch"
  enforcement = "active"

  conditions = {
    ref_name = {
      include = ["refs/heads/main"]
      exclude = []
    }
  }

  rules = {
    pull_request = {
      required_approving_review_count   = 2
      require_code_owner_review         = true
      required_review_thread_resolution = true
    }
    required_signatures     = true
    required_linear_history = true
    deletion                = true
    non_fast_forward        = true
  }
}
```

### Tag Protection Ruleset

```terraform
module "tag_protection" {
  source = "kewalaka/avm-res-githubrepository/github//modules/ruleset"
  # For local development: source = "./modules/ruleset"

  name       = "release-tag-protection"
  repository = {
    id   = "repo-id"
    name = "my-repository"
  }
  target      = "tag"
  enforcement = "active"

  conditions = {
    ref_name = {
      include = ["refs/tags/v*"]
      exclude = []
    }
  }

  rules = {
    creation = true
    deletion = true
    update   = true
    tag_name_pattern = {
      operator = "regex"
      pattern  = "^v[0-9]+\\.[0-9]+\\.[0-9]+$"
      name     = "Semantic Versioning"
    }
  }
}
```

### Push Protection Ruleset

```terraform
module "workflow_protection" {
  source = "kewalaka/avm-res-githubrepository/github//modules/ruleset"
  # For local development: source = "./modules/ruleset"

  name       = "workflow-file-protection"
  repository = {
    id   = "repo-id"
    name = "my-repository"
  }
  target      = "push"
  enforcement = "active"

  conditions = {
    ref_name = {
      include = ["~ALL"]
      exclude = []
    }
  }

  rules = {
    required_workflows = {
      required_workflow = [
        {
          path = ".github/workflows/ci.yml"
        }
      ]
    }
  }
}
```

## Rule Behavior Notes

### Update vs Non-Fast-Forward

The `update` and `non_fast_forward` rules work together to control branch update behavior:

- **`non_fast_forward`**: When set to `true`, blocks non-fast-forward pushes (force pushes that rewrite history)
- **`update`**: Controls whether updates to refs are allowed. When `non_fast_forward` is enabled, the `update` rule automatically sets `update_allows_fetch_and_merge` to `false` to enforce the non-fast-forward restriction

**Best practice**: Use `non_fast_forward = true` alone to block force pushes. Only set `update = true` explicitly if you need to block all updates regardless of fast-forward status.

## Migration from Branch Protection

Rulesets provide more flexibility than classic branch protection policies and are recommended for new implementations. Key differences:

- **Target flexibility**: Rulesets can target branches, tags, or push events
- **Pattern matching**: More powerful include/exclude patterns
- **Bypass actors**: More granular control with bypass modes
- **Rule composition**: More comprehensive rule set including workflows and patterns
- **Enforcement modes**: Support for evaluate mode to test rules before enforcement

When migrating from branch protection to rulesets:

1. Review existing branch protection patterns
2. Create equivalent rulesets with the same or enhanced rules
3. Test in evaluate mode before switching to active
4. Remove old branch protection policies once rulesets are verified

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9, < 2.0)

- <a name="requirement_github"></a> [github](#requirement\_github) (~> 6.5)

<!-- markdownlint-disable MD013 -->
## Resources

The following resources are used by this module:

- [github_repository_ruleset.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_conditions"></a> [conditions](#input\_conditions)

Description: Conditions for the ruleset.
- ref\_name: Reference name patterns to include and exclude.
  - include: List of ref name patterns to include (e.g., ["refs/heads/main", "refs/heads/release/*"]).
  - exclude: List of ref name patterns to exclude (e.g., ["refs/heads/dev"]).

Type:

```hcl
object({
    ref_name = object({
      include = list(string)
      exclude = optional(list(string), [])
    })
  })
```

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the ruleset.

Type: `string`

### <a name="input_repository"></a> [repository](#input\_repository)

Description: The repository object containing id and name.

Type:

```hcl
object({
    id   = string
    name = string
  })
```

### <a name="input_target"></a> [target](#input\_target)

Description: The target of the ruleset. Possible values are: branch, tag, push.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_bypass_actors"></a> [bypass\_actors](#input\_bypass\_actors)

Description: List of actors that can bypass the ruleset.
- actor\_id: The ID of the actor (user, team, or app).
- actor\_type: The type of actor. Possible values: RepositoryRole, Team, Integration, OrganizationAdmin.
- bypass\_mode: The bypass mode. Possible values: always, pull\_request. Defaults to always.

Type:

```hcl
list(object({
    actor_id    = number
    actor_type  = string
    bypass_mode = optional(string, "always")
  }))
```

Default: `[]`

### <a name="input_enforcement"></a> [enforcement](#input\_enforcement)

Description: The enforcement level of the ruleset. Possible values are: disabled, active, evaluate.

Type: `string`

Default: `"active"`

### <a name="input_rules"></a> [rules](#input\_rules)

Description: Rules to apply in the ruleset. All rules are optional.  

Pull Request Rules:
- pull\_request: Require pull request before merging.
  - dismiss\_stale\_reviews\_on\_push: Dismiss stale reviews on push.
  - require\_code\_owner\_review: Require code owner review.
  - require\_last\_push\_approval: Require approval of the most recent push.
  - required\_approving\_review\_count: Number of required approving reviews.
  - required\_review\_thread\_resolution: Require all conversations to be resolved.  

Status Check Rules:
- required\_status\_checks: Require status checks to pass.
  - required\_check: List of required status checks.
    - context: The status check context name.
    - integration\_id: Optional integration ID.
  - strict\_required\_status\_checks\_policy: Require branches to be up to date.  

Commit Rules:
- committer\_email\_pattern: Require committer email to match pattern.
- commit\_message\_pattern: Require commit message to match pattern.
- commit\_author\_email\_pattern: Require commit author email to match pattern.  
  Each pattern object contains:
  - operator: The operator (starts\_with, ends\_with, contains, regex).
  - pattern: The pattern to match.
  - name: Optional name for the rule.
  - negate: Whether to negate the match.  

Branch Rules:
- creation: Block creation of matching refs.
- update: Block update of matching refs (set to true with update\_allows\_fetch\_and\_merge = true for non-fast-forward rule).
- deletion: Block deletion of matching refs.
- required\_linear\_history: Require linear history.
- required\_signatures: Require signed commits.
- non\_fast\_forward: Block non-fast-forward pushes.
- required\_deployments: Require deployments to succeed.
  - required\_deployment\_environments: List of required deployment environments.  

Tag Rules:
- tag\_name\_pattern: Require tag name to match pattern (similar structure to commit patterns).  

Workflow Rules:
- required\_workflows: Require workflows to pass.
  - required\_workflow: List of required workflows.
    - path: Path to the workflow file.
    - repository\_id: Optional repository ID.
    - ref: Optional ref (branch/tag).

Type:

```hcl
object({
    # Pull request rules
    pull_request = optional(object({
      dismiss_stale_reviews_on_push     = optional(bool, false)
      require_code_owner_review         = optional(bool, false)
      require_last_push_approval        = optional(bool, false)
      required_approving_review_count   = optional(number, 1)
      required_review_thread_resolution = optional(bool, false)
    }))

    # Status check rules
    required_status_checks = optional(object({
      required_check = list(object({
        context        = string
        integration_id = optional(number)
      }))
      strict_required_status_checks_policy = optional(bool, false)
    }))

    # Commit rules
    committer_email_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    commit_message_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    commit_author_email_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    # Branch rules
    creation                 = optional(bool)
    update                   = optional(bool)
    deletion                 = optional(bool)
    required_linear_history  = optional(bool)
    required_signatures      = optional(bool)
    non_fast_forward         = optional(bool)
    required_deployments     = optional(object({
      required_deployment_environments = list(string)
    }))

    # Tag rules
    tag_name_pattern = optional(object({
      operator = string
      pattern  = string
      name     = optional(string)
      negate   = optional(bool, false)
    }))

    # Workflow rules
    required_workflows = optional(object({
      required_workflow = list(object({
        path         = string
        repository_id = optional(number)
        ref          = optional(string)
      }))
    }))
  })
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_etag"></a> [etag](#output\_etag)

Description: The ETag of the ruleset.

### <a name="output_id"></a> [id](#output\_id)

Description: The ID of the ruleset.

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the ruleset.

### <a name="output_node_id"></a> [node\_id](#output\_node\_id)

Description: The Node ID of the ruleset.

### <a name="output_ruleset_id"></a> [ruleset\_id](#output\_ruleset\_id)

Description: The ruleset ID within GitHub.

## Modules

No modules.

<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft's privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->