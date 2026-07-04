# Exercise 02: Package and Publish

## Objective
Package the chart into a versioned artifact and prepare it for registry publishing.

## Why this matters
Packaging a chart into a `.tgz` file is how enterprises create immutable artifacts for promotion and reuse. These artifacts can then be stored in registries like GHCR [web:37][web:42].

## Commands

From the repo root:

```bash
make helm-package-chart-with-version
make helm-oci-registry-login
make helm-push-chart-packag-to-registry
```

(Optional, after push):

```bash
make helm-show-chart-metadata
make helm-show-chart-values
```

## Expected outcome

- `dist/catalog-service-0.1.0.tgz` exists.
- `make helm-oci-registry-login` succeeds against `ghcr.io` using credentials from `.secrets`.
- `make helm-push-chart-packag-to-registry` publishes the chart to `oci://ghcr.io/<GHCR_USERNAME>/helm-lab`.

## What to verify

- Chart version in `Chart.yaml` matches `CHART_VERSION` in the Makefile.
- The packaged file name matches `CHART_PKG` (e.g. `catalog-service-0.1.0.tgz`).
- GHCR shows the uploaded chart artifact under `<GHCR_USERNAME>/helm-lab` [web:81][web:82].

## Common failures

- `.secrets` missing or incomplete (`GHCR_USERNAME`/`GHCR_PAT` not set).
- Package not found because `helm-package-chart-with-version` hasn’t run.
- GHCR authentication errors (wrong token scopes or username).

## Fix approach

- Create `.secrets` with `GHCR_USERNAME` and `GHCR_PAT`.
- Verify chart version is correct before packaging.
- Confirm PAT has `read:packages` and `write:packages` scopes [web:85][web:88].