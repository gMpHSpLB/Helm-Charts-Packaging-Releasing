SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show top-level targets
	@echo ""
	@echo "Usage:"
	@echo "  make <target>"
	@echo ""
	@echo "Top-level targets:"
	@echo "  setup-minikube           Start/ensure Minikube cluster"
	@echo "  helm-lab-dev             Run Helm dev workflow (packaging + dev deploy)"
	@echo "  helm-lab-all             Run full Helm lab scripts"
	@echo ""
	@echo "See Makefile_Setup and Makefile_Helm_Packaging_Releasing for detailed targets."
	@echo ""

# Convenience wrapper to call setup Makefile targets
.PHONY: setup-minikube
setup-minikube: ## Ensure Minikube cluster is running with correct profile
	$(MAKE) -f Makefile_Setup ensure-minikube
	$(MAKE) -f Makefile_Setup enable-minikube-addons
	$(MAKE) -f Makefile_Setup check-clusterinfo
	$(MAKE) -f Makefile_Setup kubectl-get-nodes

# Wrapper to run dev-focused Helm workflow
.PHONY: helm-lab-dev
helm-lab-dev: ## Ensure Minikube, then run dev Helm workflow
	$(MAKE) setup-minikube
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-scaffold-new-chart
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-lint-validate-chart
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-template-dev
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-package-chart-with-version
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-dev-release-in-namespace
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-show-status-dev-release-in-namespace

# Wrapper to run all scripts (end-to-end lab)
.PHONY: helm-lab-all
helm-lab-all: ## Ensure Minikube, then run all lab scripts
	$(MAKE) setup-minikube
	./run_all_scripts.sh

# Example: safe usage pattern
# Start from a clean shell.
# Run:
# bash
# make setup-minikube
# This ensures k8s-learning profile is up and configured.

# Then run:
# bash
# make helm-lab-dev
# or:
# bash
# make helm-lab-all
# All Helm-related targets are now guaranteed to run against the same Minikube profile you designed for the project.