# Exercise 04: Dependency Management

## Objective
Add chart dependencies and rebuild them reproducibly from the lockfile.

## Why this matters
Parent charts often depend on services such as Redis or PostgreSQL. Helm dependency build reconstructs the `charts/` directory from `Chart.lock`, which supports repeatable builds [web:18].

## Commands
```bash
make dependency-update
make dependency-build
```

## Expected outcome
- Dependencies are downloaded.
- `Chart.lock` is created or updated.
- Dependencies are present under `charts/`.

## What to verify
- Dependency versions are pinned.
- Build is deterministic.
- The parent chart renders correctly with dependencies included.

## Common failures
- Incorrect dependency repository URL.
- Version mismatch in `Chart.yaml`.
- Missing lockfile.

## Fix approach
- Correct repository and version declarations.
- Re-run dependency update.
- Commit both `Chart.yaml` and `Chart.lock`.