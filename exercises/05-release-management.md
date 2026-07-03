# Exercise 05: Release Management

## Objective
Install or upgrade the same chart across multiple namespaces and environments.

## Why this matters
Helm is a release manager when used to promote the same chart through dev, staging, and prod using different release names and values files.

## Commands
```bash
make upgrade-install-dev
make upgrade-install-staging
make upgrade-install-prod
make history-dev
make get-manifest-dev
make get-values-dev
```

## Expected outcome
- Releases exist in their respective namespaces.
- History shows revisions.
- Manifest and values reflect what is deployed.

## What to verify
- Dev, staging, and prod are isolated.
- Release names are environment-specific.
- The same chart can be promoted with different values.

## Common failures
- Namespace does not exist.
- Wrong values file.
- Release name collision.

## Fix approach
- Use `--create-namespace`.
- Confirm environment-specific values.
- Keep release names unique per environment.