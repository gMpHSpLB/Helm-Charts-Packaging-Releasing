# Exercise 07: Environment and Troubleshooting

## Objective
Inspect Helm environment settings and verify release health.

## Why this matters
Helm environment inspection is useful when diagnosing differences between local development, CI runners, and cluster access settings [web:19].

## Commands
```bash
make env
make list-dev
make status-dev
make test-dev
```

## Expected outcome
- Helm environment variables are displayed.
- Release status is visible.
- Tests run against the deployed release.

## What to verify
- Cache, config, data, and plugin paths are correct.
- Release is in a healthy state.
- Test hooks complete successfully.

## Common failures
- Wrong kube context.
- Missing Helm plugin.
- Test pod fails due to service readiness.

## Fix approach
- Check `KUBECONFIG` and current context.
- Verify plugin installation.
- Review test pod logs with `--logs`.