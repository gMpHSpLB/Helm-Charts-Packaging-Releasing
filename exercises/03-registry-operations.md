# Exercise 03: Registry Operations

## Objective
Login to a registry, push a chart, pull it back, and inspect registry discovery.

## Why this matters
Chart registries are the source of truth in many enterprise pipelines. Helm supports OCI registry workflows for storing and consuming packaged charts [web:10][web:12][web:14].

## Commands
```bash
make registry-login
make push
make pull
make repo-add
make repo-update
make search-repo
```

## Expected outcome
- Registry login succeeds.
- Chart push succeeds.
- Chart can be pulled back by version.
- Repo search returns expected chart entries.

## What to verify
- The pushed version is immutable.
- The pulled artifact matches the published version.
- Search results show the chart source.

## Common failures
- Registry authentication failure.
- Incorrect OCI path.
- Missing chart package.

## Fix approach
- Verify registry hostname and credentials.
- Ensure the package exists in `dist/`.
- Check chart version and OCI path syntax.