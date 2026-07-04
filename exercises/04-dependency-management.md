# Exercise 04: Dependency Management

## Objective
Download chart dependencies and rebuild them reproducibly from `Chart.lock`.

## Why this matters
Parent charts often rely on subcharts (e.g., database or cache). Helm dependency update and build ensure that dependencies are pinned and reproducible via `Chart.lock` [web:18][web:25].

## Commands

From the repo root:

```bash
make helm-dependency-update-in-lockfile
make helm-dependency-build-from-loackfile
make helm-template-dev
```

## Expected outcome

- `Chart.lock` is created or updated in `charts/catalog-service`.
- Subcharts appear under `charts/catalog-service/charts/`.
- Dev template renders correctly with dependencies included.

## What to verify

- `Chart.lock` lists dependency name, version, and repo.
- The `charts/` subdirectory contains the dependency chart archives.
- `helm template` output includes resources from dependencies as expected.

## Common failures

- Missing dependency entries in `Chart.yaml`.
- Incorrect repository URLs for dependencies.
- Lockfile out of sync with declared dependencies.

## Fix approach

- Define dependencies in `Chart.yaml` with correct name, version, and repo.
- Run `make helm-dependency-update-in-lockfile` again to refresh.
- Commit both `Chart.yaml` and `Chart.lock` for reproducible builds [web:18][web:25].