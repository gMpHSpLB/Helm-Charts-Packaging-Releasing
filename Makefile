SHELL := /bin/bash

.DEFAULT_GOAL := help

RED    := \033[1;31m
YELLOW := \033[1;33m
GREEN  :="\033[1;32m"
CYAN   := \033[1;36m
RESET  := \033[0m

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

.PHONY: helm-lab-dev
helm-lab-dev: ## Ensure Minikube, then run dev Helm workflow (interactive)
	@echo " >>>>>>>>>>>>>>>>    START   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

	@echo "Step 1: Setup Minikube"; \
	echo -e "$(CYAN)Press ENTER to run Step 1...$(RESET)"; \
	read -r _; \
	$(MAKE) setup-minikube; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 2: Scaffold new chart (if needed)"; \
	echo -e "$(CYAN)Press ENTER to run Step 2...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-scaffold-new-chart; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 3: Lint chart"; \
	echo -e "$(CYAN)Press ENTER to run Step 3...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-lint-validate-chart; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 4: Template dev manifests"; \
	echo -e "$(CYAN)Press ENTER to run Step 4...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-template-dev; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 5: Package chart with version"; \
	echo -e "$(CYAN)Press ENTER to run Step 5...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-package-chart-with-version; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 6: Reset dev release and namespace"; \
	echo -e "$(CYAN)Press ENTER to run Step 6...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-reset-dev-release; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 7: Install/upgrade dev release in namespace"; \
	echo -e "$(CYAN)Press ENTER to run Step 7...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-upgrade-install-dev-release-in-namespace; \
	echo " --------------------------------------------------------------------------------"

	@echo "Step 8: Show dev release status"; \
	echo -e "$(CYAN)Press ENTER to run Step 8...$(RESET)"; \
	read -r _; \
	$(MAKE) -f Makefile_Helm_Packaging_Releasing helm-show-status-dev-release-in-namespace; \
	echo " --------------------------------------------------------------------------------"
	@echo " <<<<<<<<<<<<<<<<    END    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

# Wrapper to run all scripts (end-to-end lab)
.PHONY: helm-lab-all
helm-lab-all: ## Ensure Minikube, then run all lab scripts
	@echo "Setup Minikube"; \
	echo -e "$(CYAN)Press ENTER to run Step 1...$(RESET)"; \
	read -r _; \
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