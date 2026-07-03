# Exercise 06: Diff and Rollback

## Objective
Preview a release change before applying it and recover from a bad upgrade.

## Why this matters
In enterprise operations, every production upgrade should be reviewed before application. Helm diff gives change visibility, and rollback provides fast recovery.

## Commands
```bash
make diff-dev
make upgrade-install-dev
make rollback-dev
make history-dev
```

## Expected outcome
- Diff shows what will change.
- Upgrade applies a new revision.
- Rollback restores a previous revision.
- History confirms the revision sequence.

## What to verify
- Manifest changes are visible before deploy.
- Revision numbers increase after upgrade.
- Rollback returns the release to a known-good state.

## Common failures
- Diff plugin not installed.
- Wrong revision number during rollback.
- Release history shorter than expected.

## Fix approach
- Install `helm-diff`.
- Check `helm history` before rollback.
- Roll back to a valid revision.