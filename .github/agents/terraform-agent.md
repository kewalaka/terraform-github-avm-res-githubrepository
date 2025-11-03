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

## Module Update Playbook

- Mirror provider schema into module variables first, then surface identical
  objects in root-level `variables.*.tf` files so call sites and submodules stay
  synchronized.
- Encode optional blocks with dynamic constructs and wrap nested lookups in
  `try()` to keep null-safe defaults; map simple boolean toggles directly on the
  resource block to match the GitHub provider contract.
- Keep reusable rule fragments grouped (pull request, status checks, scanning,
  commit patterns, branch settings) to make Terraform docs generation produce a
  predictable layout for contributors.
- After schema-driven edits, run `terraform fmt` on the touched module and
  `PORCH_NO_TUI=1 ./avm pre-commit` to regenerate module READMEs; stage the
  doc output before launching the PR check.

## Debugging Checklist

- If Terraform plan errors reference unsupported arguments, re-run the schema
  query above and compare nested block names to the dynamic block labels.
- Validate that every new input has matching descriptions and defaults in both
  module `variables.tf` and the top-level `variables.<module>.tf` file.
- Confirm example configurations exercise new fields where practical so the AVM
  example plans surface regressions early.

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

## References

- [Azure Verified Modules testing](https://azure.github.io/Azure-Verified-Modules/contributing/terraform/testing/)
- [GitHub repository ruleset resource](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_ruleset)
