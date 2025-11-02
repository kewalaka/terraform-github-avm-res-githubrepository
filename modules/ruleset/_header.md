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
  source = "Azure/avm-res-githubrepository/github//modules/ruleset"

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
  source = "Azure/avm-res-githubrepository/github//modules/ruleset"

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
  source = "Azure/avm-res-githubrepository/github//modules/ruleset"

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
