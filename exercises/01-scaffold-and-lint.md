# Exercise 01: Scaffold and Lint

## Objective
Create a fresh Helm chart and validate that it is structurally correct.

## Why this matters
In enterprise workflows, chart quality starts with linting and basic rendering checks. Helm lint helps catch structural issues before a chart is packaged or deployed [web:27][web:29].

## Commands

From the repo root:

```bash
make helm-scaffold-new-chart
make helm-lint-validate-chart
make helm-template-dev
```

## Expected outcome

- `charts/catalog-service/` exists with a standard Helm chart structure.
- `make helm-lint-validate-chart` completes without errors.
- `make helm-template-dev` renders Kubernetes manifests for the dev environment using `environments/dev.yaml`.

## What to verify

- Chart directory structure looks valid (`Chart.yaml`, `values.yaml`, `templates/`).
- Lint output shows either “0 chart(s) linted, 0 chart(s) failed” or similar success.
- Rendered manifests include your expected resources (Deployment, Service, etc.) with dev-specific values.

## Common failures

- Missing chart directory (`charts/catalog-service`).
- Invalid YAML indentation or missing keys in templates.
- Dev values file path mismatch (`environments/dev.yaml` not found).

## Fix approach

- Ensure `CHART_DIR` and `DEV_VALUES` in the Makefile point to existing paths.
- Correct YAML and template syntax.
- Re-run the three commands until lint and template succeed [web:27][web:29].