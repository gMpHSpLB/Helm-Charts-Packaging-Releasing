This lab models an enterprise Helm workflow where a chart is created, 
validated, packaged, published to a registry, rebuilt from dependency 
locks, deployed to multiple environments, tested, diffed, and rolled 
back when needed.

This project uses Helm packaging to create versioned chart artifacts 
and publishes them to GitHub Container Registry using OCI references.

# Goals
## This lab demonstrates how Helm works as:
**A package manager for reusable chart artifacts.
A release manager for installing, upgrading, and rolling back releases.
A versioned delivery tool for promoting chart releases across environments.
A registry client for pushing, pulling, and inspecting chart artifacts.
A dependency manager for reproducible subchart builds.
A troubleshooting tool for inspecting Helm environment and release state.**

**The chart is scaffolded locally with Helm, customized with templates and 
base values, and then deployed to Kubernetes using environment-specific 
overrides. For packaging and release distribution, the chart is packaged 
as a Helm archive and published to GitHub Container Registry using OCI 
references. This keeps the runtime deployment separate from the artifact 
registry workflow.**

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

# GitHub Container Registry (GHCR) as OCI artifacts using helm registry
In this lab, charts are stored in GitHub Container Registry (GHCR) as OCI artifacts using helm registry login, helm push, and helm pull with oci://ghcr.io/... paths. Traditional helm repo add, helm repo update, and helm search repo are only required when using index-based HTTP Helm repositories (for example, public chart repos). Since GHCR is used purely as an OCI registry here, those helm repo commands are optional demos and not part of the main workflow.

# Dependency Management (PostgreSQL subchart)
This exercise demonstrates Helm’s dependency system using Bitnami PostgreSQL as a subchart. The parent chart (charts/catalog-service/Chart.yaml) declares a postgresql dependency pointing to the Bitnami Helm repository. When we run helm dependency update, Helm reads the dependencies block, downloads the PostgreSQL chart into charts/catalog-service/charts/, and writes a Chart.lock pinning the exact version.

helm dependency build can later rebuild the charts/ directory from Chart.lock, ensuring reproducible releases. With postgresql.enabled: true in values.yaml (or environment-specific values), helm template renders both the catalog service and PostgreSQL resources, illustrating how a parent chart can consume database subcharts in a controlled, versioned way.

# Release Management
This exercise installs or upgrades the same Helm chart into three isolated Kubernetes namespaces: dev, staging, and prod. It demonstrates release lifecycle operations such as helm install, helm upgrade, helm history, helm get manifest, and helm get values. Unlike the GHCR/OCI exercises, this step does not publish or retrieve chart packages from a registry; instead, it consumes the packaged chart and deploys it into the cluster.