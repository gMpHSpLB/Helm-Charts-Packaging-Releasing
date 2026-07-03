# Exercise 02: Package and Publish

## Objective
Package the chart into a versioned artifact and prepare it for registry publishing.

## Why this matters
Enterprises distribute Helm charts as immutable artifacts so the same package can be promoted through environments. OCI-based registries are a common distribution mechanism for Helm charts [web:10][web:21].

## Commands
```bash
make package
make show-chart
make show-values
```

## Expected outcome
- A `.tgz` package is created in `dist/`.
- Chart metadata is visible.
- Default values are inspectable before release.

## What to verify
- `version` and `appVersion` are correct.
- Package name matches the chart version.
- Default configuration matches the intended baseline.

## Common failures
- Version mismatch.
- Missing chart metadata.
- Package output directory not created.

## Fix approach
- Update chart version before packaging.
- Confirm `Chart.yaml` fields.
- Ensure `dist/` exists.