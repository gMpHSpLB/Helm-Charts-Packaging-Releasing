# Exercise 05: Release Management

## Objective
Install or upgrade the same chart across multiple namespaces and environments and inspect the dev release.

## Why this matters
Helm is a release manager when you use it to install and upgrade the same chart in dev, staging, and prod with different values, release names, and namespaces [web:24][web:45].

## Commands

From the repo root:

```bash
make helm-upgrade-install-dev-release-in-namespace
make helm-upgrade-install-staging-release-in-namespace
make helm-upgrade-install-prod-release-in-namespace
make helm-history-dev-release-in-namespace
make helm-get-manifest-dev-release-in-namespace
make helm-get-values-dev-release-in-namespace
```

## Expected outcome

- Releases exist in `catalog-dev`, `catalog-staging`, and `catalog-prod` namespaces.
- Dev release history shows revisions.
- Dev manifest and values reflect the deployed state.

## What to verify

- Namespaces are created (`--create-namespace` used).
- `helm history $(RELEASE_DEV)` shows revision numbers increasing on upgrades.
- `helm get manifest` and `helm get values` output match your expectations for dev configuration.

## Common failures

- Values files for staging/prod not present or misnamed.
- Namespace mismatch (e.g., `NS_STAGING` vs actual namespace).
- Release name collision across environments if names are not unique.

## Fix approach

- Create `environments/dev.yaml`, `staging.yaml`, and `prod.yaml` with correct values.
- Ensure `NS_DEV`, `NS_STAGING`, and `NS_PROD` match your desired namespaces.
- Use distinct release names per environment as defined in the Makefile.