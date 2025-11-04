# GitHub repository with rulesets

This example demonstrates the use of repository rulesets to enforce policies on branches, tags, and pushes.

Rulesets are the newer way to protect branches and tags, offering more flexibility than classic branch protection policies.

This example shows:
- Branch protection rulesets for `main` and `release/*` branches
- Tag protection rulesets for semantic versioning
- Using evaluate mode for testing before enforcement
- Multiple rule types: pull requests, status checks, signed commits, linear history, and more

GitHub App permissions required:

- Repository Administration: write

Note: Rulesets require the repository to exist first. This example creates a new repository with rulesets applied.

ref: <https://docs.github.com/en/rest/repos/rules>
