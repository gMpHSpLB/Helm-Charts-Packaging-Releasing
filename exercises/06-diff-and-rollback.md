# Exercise 06: Diff and Rollback

## Objective
Preview dev release changes before upgrading and roll back to a previous revision if needed.

## Why this matters
Previewing changes before applying them and having a rollback path are key parts of safe production operations. Helm diff and rollback support this workflow directly [web:31][web:36].

## Commands

From the repo root:

```bash
make helm-diff-dev-release-change-before-apply-in-namespace
make helm-upgrade-install-dev-release-in-namespace
make helm-history-dev-release-in-namespace
make helm-rollback-dev-release-to-previous-version-in-namespace
make helm-history-dev-release-in-namespace
```

## Expected outcome

- Diff displays what will change for the dev release.
- Upgrade creates a new revision in dev history.
- Rollback restores the previous revision.
- History confirms the revision sequence before and after rollback.

## What to verify

- `helm diff` output shows resource changes clearly.
- `helm history` lists revision numbers, timestamps, and descriptions.
- After rollback, the current revision reflects the rolled-back state.

## Common failures

- `helm diff` plugin not installed.
- Wrong revision number supplied to rollback.
- Dev release not yet installed (no history to diff or rollback).

## Fix approach

- Install `helm-diff` plugin if needed.
- Check `helm history` before rollback to choose the correct revision.
- Ensure the dev release exists by running the dev upgrade/install first.