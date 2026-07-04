# Exercise 07: Environment and Troubleshooting

## Objective
Inspect Helm environment settings and verify release health for the dev environment.

## Why this matters
Helm environment inspection helps diagnose issues with cache, config, and data paths. Release status and tests verify that the deployed chart is healthy [web:19][web:33][web:36].

## Commands

From the repo root:

```bash
make helm-show-env-variables
make helm-list-dev-releases-in-namespace
make helm-show-status-dev-release-in-namespace
make helm-run-tests-for-dev-release-in-namespace
```

## Expected outcome

- Helm environment variables and paths are displayed.
- Dev releases are listed in the `catalog-dev` namespace.
- Dev release status shows a healthy state (e.g., `deployed`).
- Helm tests run against the dev release and logs are printed.

## What to verify

- `helm env` shows cache, config, and data directories you expect.
- `helm list -n catalog-dev` includes your dev release.
- `helm status` shows the correct namespace and resources.
- Test hooks complete successfully and verify the service readiness.

## Common failures

- Wrong kube context or namespace.
- Tests fail due to service not ready or wrong test manifest.
- Helm plugins or environment paths misconfigured.

## Fix approach

- Confirm kube context and namespace (`NS_DEV`) are correct.
- Inspect test logs for root cause of failures.
- Adjust test pod/job definitions under `templates/tests/` as needed [web:36][web:33].