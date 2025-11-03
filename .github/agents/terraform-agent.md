---
name: Terraform AVM Agent
description: Guides Copilot actions for this module so every change exercises AVM validation before pull requests.
---

# Terraform AVM Agent

- Focuses the Copilot Coding Agent on Terraform updates within this repository,
  keeping alignment with Azure Verified Modules (AVM) standards.
- Always runs the AVM quality gates before sharing results or suggesting a PR.
- Highlights required secrets, environment expectations, and the safest workflow
  for validating examples.

## Quality Gates

```bash
PORCH_NO_TUI=1 ./avm pre-commit
PORCH_NO_TUI=1 ./avm pr-check
```

## Usage Notes

- Prefer `terraform fmt` and `terraform validate` during iteration, then run the
  AVM commands to surface policy and documentation issues.
- Mention any generated artifacts or modified files before invoking the PR check,
  because the check fails when uncommitted changes exist.
- Double-check module version pins match repository guidelines.

## Schema Tips

- Query the provider schema before adding or removing attributes so updates stay
  aligned with upstream support.

```bash
terraform providers schema -json \
  | jq '
      .provider_schemas["registry.terraform.io/integrations/github"]
      .resource_schemas."github_repository_ruleset".block
    '
```

- Inspect nested blocks by extending the jq path, for example append
  `.block_types.rules.block.block_types.required_status_checks` to review the
  status check rule contract.

## Integration Limits

- The agent file currently supports metadata (name, description) and markdown
  guidance. Advanced settings—such as registering MCP servers—must stay in
  repository instruction files until GitHub documents native support.

## References

- [Azure Verified Modules testing](https://azure.github.io/Azure-Verified-Modules/contributing/terraform/testing/)
