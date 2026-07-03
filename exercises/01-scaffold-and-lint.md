# Exercise 01: Scaffold and Lint

## Objective
Create a fresh Helm chart and validate that it is structurally correct.

## Why this matters
In enterprise teams, the first gate for chart quality is linting. Helm lint checks whether the chart is well-formed and catches problems before deployment [web:27].

## Commands
```bash
make scaffold
make lint
make template-dev
```

## Expected outcome
- A new chart exists under `charts/catalog-service/`.
- `make lint` passes without errors.
- `make template-dev` renders Kubernetes manifests successfully.

## What to verify
- Chart directory structure looks valid.
- Templates render without YAML syntax issues.
- Environment-specific values from `environments/dev.yaml` are applied.

## Common failures
- Missing template files.
- Invalid YAML indentation.
- Undefined or misspelled values keys.

## Fix approach
- Correct YAML indentation.
- Review `values.yaml` and environment overrides.
- Re-run `make lint` and `make template-dev`.