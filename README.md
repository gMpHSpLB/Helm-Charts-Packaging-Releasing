This lab models an enterprise Helm workflow where a chart is created, 
validated, packaged, published to a registry, rebuilt from dependency 
locks, deployed to multiple environments, tested, diffed, and rolled 
back when needed.

# Goals
## This lab demonstrates how Helm works as:
**A package manager for reusable chart artifacts.
A release manager for installing, upgrading, and rolling back releases.
A versioned delivery tool for promoting chart releases across environments.
A registry client for pushing, pulling, and inspecting chart artifacts.
A dependency manager for reproducible subchart builds.
A troubleshooting tool for inspecting Helm environment and release state.**

# Requirements:
**    Helm 3.x.
    Kubernetes cluster such as Minikube or a real cluster.
    Access to a container or OCI registry for chart publishing.
    make.
    Optional Helm plugin: helm-diff.**

# Versioning strategy
## Use the following versioning model:
    - chart version: increment for chart packaging changes.
    - appVersion: increment for application image changes.
    - release names: keep environment-specific names separate.

## Semantic versioning rules:
    - Patch: template fixes, metadata changes, small config updates.
    - Minor: new optional chart features or new values.
    - Major: breaking changes in schema or resource behavior.

# GHCR-backed Helm OCI pipeline
## GHCR overview
**This lab uses GitHub Container Registry (GHCR) as the Helm OCI registry. GHCR supports OCI artifacts and works cleanly with Helm 3’s registry commands, which makes it ideal for a CI/CD-driven Helm portfolio. Charts are pushed as OCI artifacts to ghcr.io under your GitHub namespace, then pulled back by exact version for deployment.**

### Registry details
    - Registry host: ghcr.io.
    - Namespace: ghcr.io/<github-username>.
    - Chart repository path: ghcr.io/<github-username>/helm-lab.
    - Chart artifact name: catalog-service-<chart-version>.tgz.
    - Authentication: GitHub username + PAT with read:packages and write:packages.