# Rulesets Example

This example demonstrates how to use the repository rulesets feature to enforce policies on branches, tags, and pushes.

## Features Demonstrated

- **Branch Protection with Rulesets**: Protect the `main` and `release/*` branches with comprehensive rules
- **Tag Protection**: Enforce semantic versioning for tags matching `v*` pattern
- **Flexible Enforcement**: Use `active` mode for production branches and `evaluate` mode for testing
- **Multiple Rule Types**: 
  - Pull request requirements (reviews, code owners, conversation resolution)
  - Required status checks
  - Signed commits and linear history
  - Protection against deletions and force pushes
  - Tag naming patterns

## Rulesets vs Branch Protection

This example shows how rulesets provide a modern alternative to classic branch protection:

### Advantages of Rulesets

1. **Target Flexibility**: Can protect branches, tags, or apply to push events
2. **Pattern Matching**: More powerful include/exclude patterns with support for wildcards
3. **Enforcement Modes**: 
   - `active` - Rules are enforced
   - `evaluate` - Rules are checked but not enforced (useful for testing)
   - `disabled` - Rules are not checked
4. **Consistent Configuration**: Same rule structure across different target types
5. **Better Bypass Control**: Granular control with bypass actors and modes

### Migration Path

If you're currently using branch protection policies:

1. Create equivalent rulesets with `enforcement = "evaluate"` to test
2. Verify the rules work as expected
3. Switch to `enforcement = "active"` 
4. Remove old branch protection policies

## Usage

To run this example:

```bash
# Set required variables
export TF_VAR_github_organization_name="your-org-name"

# Optionally, configure GitHub App authentication
export TF_VAR_github_app_id="your-app-id"
export TF_VAR_github_app_installation_id="your-installation-id"
export TF_VAR_github_app_pem_file="path/to/pem"

# Or use a GitHub token
export GITHUB_TOKEN="your-token"

# Initialize and apply
terraform init
terraform plan
terraform apply
```

## Rulesets Configured

### 1. Main Branch Protection (`main_protection`)

- **Target**: `refs/heads/main`
- **Enforcement**: Active
- **Rules**:
  - Requires 2 approving reviews
  - Requires code owner review
  - Requires conversation resolution
  - Requires last push approval
  - Requires status check `ci/tests` to pass
  - Requires branches to be up to date (strict)
  - Requires signed commits
  - Requires linear history
  - Blocks deletions
  - Blocks non-fast-forward pushes

### 2. Release Branch Protection (`release_protection`)

- **Target**: `refs/heads/release/*`
- **Enforcement**: Active
- **Rules**:
  - Requires 1 approving review
  - Requires code owner review
  - Requires signed commits
  - Requires linear history
  - Blocks deletions
  - Blocks non-fast-forward pushes

### 3. Tag Protection (`tag_protection`)

- **Target**: `refs/tags/v*`
- **Enforcement**: Active
- **Rules**:
  - Blocks tag creation (only through proper process)
  - Blocks tag deletion
  - Blocks tag updates
  - Enforces semantic versioning pattern (v1.0.0 format)

### 4. Dev Branch Protection (`dev_protection`)

- **Target**: `refs/heads/dev`
- **Enforcement**: Evaluate (testing mode)
- **Rules**:
  - Requires 1 approving review (not enforced, only logged)

## Expected Outputs

After applying, you'll receive:

- `repository_name` - The name of the created repository
- `repository_url` - URL to access the repository
- `rulesets` - Details of all configured rulesets including IDs and ETags

## Cleanup

```bash
terraform destroy
```

Note: The repository will be archived instead of deleted by default (controlled by `archive_on_destroy`).
