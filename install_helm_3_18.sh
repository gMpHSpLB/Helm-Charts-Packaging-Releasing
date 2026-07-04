#!/usr/bin/env bash
set -euo pipefail

HELM_VERSION="v3.18.6"
ARCH="amd64"

echo "==> Checking current Helm installation"
if command -v helm >/dev/null 2>&1; then
  echo "Current Helm: $(helm version --short 2>/dev/null || helm version)"
  HELM_PATH="$(which helm)"
  echo "Helm path: ${HELM_PATH}"
else
  echo "Helm is not currently installed."
fi

echo "==> Removing Helm 4 / existing Helm binary if present"
if command -v snap >/dev/null 2>&1 && snap list helm >/dev/null 2>&1; then
  sudo snap remove helm
fi

sudo rm -f /usr/local/bin/helm
sudo rm -f /usr/bin/helm

echo "==> Downloading Helm ${HELM_VERSION}"
cd /tmp
curl -fsSLO "https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCH}.tar.gz"
curl -fsSLO "https://get.helm.sh/helm-${HELM_VERSION}-linux-${ARCH}.tar.gz.sha256sum"

echo "==> Verifying checksum"
sha256sum -c "helm-${HELM_VERSION}-linux-${ARCH}.tar.gz.sha256sum"

echo "==> Extracting and installing Helm"
tar -zxf "helm-${HELM_VERSION}-linux-${ARCH}.tar.gz"
sudo mv "linux-${ARCH}/helm" /usr/local/bin/helm
sudo chmod +x /usr/local/bin/helm

echo "==> Cleaning up"
rm -rf "linux-${ARCH}" "helm-${HELM_VERSION}-linux-${ARCH}.tar.gz" "helm-${HELM_VERSION}-linux-${ARCH}.tar.gz.sha256sum"

echo "==> Verifying installed Helm"
helm version