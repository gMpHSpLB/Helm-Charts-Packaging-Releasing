# Exercise 03: Registry Operations

## Objective
Login to GHCR, push a chart, pull it back by version, and practice Helm repo discovery commands.

## Why this matters
Registry operations are central to Helm as a package manager. GHCR supports OCI artifacts, and Helm can push/pull chart packages as OCI, giving you a realistic cloud-backed workflow [web:81][web:42].

## Commands

From the repo root:

```bash
make helm-oci-registry-login
make helm-push-chart-packag-to-registry
make helm-pull-chart-by-version-from-registry
make helm-add-a-repo
make helm-repo-update
make helm-search-repo
```

## Expected outcome

- OCI login to `ghcr.io` succeeds.
- Chart is pushed and can be pulled back by exact `CHART_VERSION`.
- An example Helm repo is added, cache updated, and search shows results.

## What to verify

- `downloads/` contains the pulled chart `.tgz` file.
- GHCR shows the chart under `<GHCR_USERNAME>/helm-lab`.
- `helm search repo $(PROJECT)` returns entries from the demo repo.

## Common failures

- Wrong `CHART_PKG` path if packaging hasn’t run.
- GHCR authentication errors.
- Dummy repo URL (`https://example.com/charts`) not reachable in real usage.

## Fix approach

- Always run `make helm-package-chart-with-version` before pushing.
- Ensure `.secrets` is present and correct.
- For a real repo, replace `https://example.com/charts` with a real chart repo URL.