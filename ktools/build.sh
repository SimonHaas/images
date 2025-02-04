#!/bin/bash

echo 'root:root' | chpasswd
echo 'ubuntu:ubuntu' | chpasswd

echo "BUILDARCH: ${BUILDARCH}"

echo 'Setup base system'
apt-get update && apt-get upgrade -y && apt-get install -y \
    curl=8.5.0* \
    wget=1.21.4* \
    git=1:2.43.0* \
    nano=7.2* \
    htop=3.3.0* \
    sudo=1.9.15* \
    gpg=2.4.4* \
    apt-transport-https=2.7.14* \
    lsb-release=12.0-2 \
    bash-completion=1:2.11-8 \
    build-essential=12.10* \
    iputils-ping=3:20240117-1build1 \
    unminimize=0.2.1 \
    ca-certificates=20240203 \
    ssh \
    netavark \
    man-db \
    qrencode \
    --no-install-recommends &&
    rm -rf /var/lib/apt/lists/*
yes | unminimize

echo 'Install kubectl'
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${BUILDARCH}/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${BUILDARCH}/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo 'Install helmfile'
curl -L -o helmfile.tar.gz https://github.com/helmfile/helmfile/releases/download/v1.0.0-rc.2/helmfile_1.0.0-rc.2_linux_${BUILDARCH}.tar.gz
tar -zxvf helmfile.tar.gz
mv helmfile /usr/local/bin/

echo 'Add helm repository'
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg >/dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list

echo 'Install talosctl'
curl -sL https://talos.dev/install | sh

echo 'Add hashicorp repository'
curl -L https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list

echo 'Install hcloud'
curl -L -o hcloud.tar.gz https://github.com/hetznercloud/cli/releases/download/v1.45.0/hcloud-linux-${BUILDARCH}.tar.gz
mkdir hcloud
tar -zxvf hcloud.tar.gz -C hcloud
mv hcloud/hcloud /usr/local/bin/

echo 'Install other apt programs'
apt-get update && apt-get install \
    python3-dev=3.12.3* \
    python3-pip=24.0* \
    python3-venv=3.12.3* \
    python3-virtualenv=20.25.0* \
    pipx=1.4.3* \
    packer=1.11.2* \
    terraform=1.9.6* \
    helm=3.16.1* \
    age=1.1.1* \
    jq=1.7.1* \
    tmux=3.4* \
    dnsutils=1:9.18.28* \
    net-tools=2.10* \
    hashcat=6.2.6* \
    podman=4.9.3* \
    tree=2.1.1* \
    ansible \
    golang \
    --no-install-recommends \
    -y && rm -rf /var/lib/apt/lists/*

echo 'Install tuf'
go install github.com/theupdateframework/go-tuf/cmd/tuf@latest

echo 'Install tuf-client'
go install github.com/theupdateframework/tuf/cmd/tuf-client@latest

echo 'Add kubectl bash completion'
echo 'source <(kubectl completion bash)' >>~/.bashrc

echo 'Install kubectl-convert'
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${BUILDARCH}/kubectl-convert
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${BUILDARCH}/kubectl-convert.sha256"
echo "$(cat kubectl-convert.sha256) kubectl-convert" | sha256sum --check
install -o root -g root -m 0755 kubectl-convert /usr/local/bin/kubectl-convert
rm kubectl-convert kubectl-convert.sha256

echo 'Install velero'
curl -L -o velero.tar.gz https://github.com/vmware-tanzu/velero/releases/download/v1.14.0/velero-v1.14.0-linux-${BUILDARCH}.tar.gz
tar -zxvf velero.tar.gz --strip-components=1 && mv velero /usr/local/bin/

echo 'Install minio client'
curl -L -o mc https://dl.min.io/client/mc/release/linux-${BUILDARCH}/mc
chmod +x mc && mv mc /usr/local/bin/

echo 'Install cloud native postgres cnpg'
curl -sSfL https://github.com/cloudnative-pg/cloudnative-pg/raw/main/hack/install-cnpg-plugin.sh | sh -s -- -b /usr/local/bin

echo 'Install sops'
curl -L -o sops https://github.com/getsops/sops/releases/download/v3.9.0/sops-v3.9.0.linux.${BUILDARCH}
mv sops /usr/local/bin/sops
chmod +x /usr/local/bin/sops

echo 'Install cosign'
curl -L -o cosign https://github.com/sigstore/cosign/releases/latest/download/cosign-linux-${BUILDARCH}
mv cosign /usr/local/bin/cosign
chmod +x /usr/local/bin/cosign

echo 'Install kubeseal'
export KUBESEAL_VERSION=0.27.1
curl -L -o kubeseal.tar.gz "https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION:?}/kubeseal-${KUBESEAL_VERSION:?}-linux-${BUILDARCH}.tar.gz"
tar -xvzf kubeseal.tar.gz kubeseal
install -m 755 kubeseal /usr/local/bin/kubeseal

echo 'Install argocd'
export ARGOCD_VERSION=$(curl -L -s https://raw.githubusercontent.com/argoproj/argo-cd/stable/VERSION)
curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/download/v$ARGOCD_VERSION/argocd-linux-${BUILDARCH}
install -m 555 argocd /usr/local/bin/argocd && \

echo 'Install kustomize'
curl -s https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh | bash
mv kustomize /usr/local/bin

echo 'Install clusterctl'
curl -L -o clusterctl https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.8.1/clusterctl-linux-${BUILDARCH}
install -o root -g root -m 0755 clusterctl /usr/local/bin/clusterctl

echo 'Install k8sgpt'
curl -L -o k8sgpt.deb https://github.com/k8sgpt-ai/k8sgpt/releases/download/v0.3.24/k8sgpt_${BUILDARCH}.deb
dpkg -i k8sgpt.deb

echo 'Install nova'
curl -L -o nova.tar.gz https://github.com/FairwindsOps/nova/releases/download/3.2.0/nova_3.2.0_linux_${BUILDARCH}.tar.gz
tar -xvf nova.tar.gz && mv nova /usr/local/bin/

echo 'Install polaris'
curl -L -o polaris.tar.gz https://github.com/FairwindsOps/polaris/releases/download/9.3.0/polaris_linux_${BUILDARCH}.tar.gz
tar -xvf polaris.tar.gz && mv polaris /usr/local/bin/

echo 'Install vcluster'
curl -L -o vcluster https://github.com/loft-sh/vcluster/releases/latest/download/vcluster-linux-${BUILDARCH}
install -c -m 0755 vcluster /usr/local/bin && rm -f vcluster

echo 'Install clusteradm'
curl -L https://raw.githubusercontent.com/open-cluster-management-io/clusteradm/main/install.sh | bash

echo 'Install longhorn'
curl -L -o longhornctl https://github.com/longhorn/cli/releases/download/v1.7.1/longhornctl-linux-${BUILDARCH}
chmod +x longhornctl && mv ./longhornctl /usr/local/bin/longhornctl

echo 'Install goldilocks'
curl -L -o goldilocks.tar.gz https://github.com/FairwindsOps/goldilocks/releases/download/v4.13.0/goldilocks_4.13.0_linux_${BUILDARCH}.tar.gz
tar -xvf goldilocks.tar.gz && mv goldilocks /usr/local/bin/

echo 'Install kyverno'
if [ "${BUILDARCH}" = "amd64" ]; then
  echo "setting buildarch for kyverno to x86_64"
  export KYVERNO_BUILDARCH=x86_64
fi
curl -L -o kyverno.tar.gz https://github.com/kyverno/kyverno/releases/download/v1.12.0/kyverno-cli_v1.12.0_linux_${KYVERNO_BUILDARCH}.tar.gz
tar -xvf kyverno.tar.gz
cp kyverno /usr/local/bin/

echo 'Install paranoia'
curl -L -o paranoia https://github.com/jetstack/paranoia/releases/download/v0.2.1/paranoia-linux-${BUILDARCH}
cp paranoia /usr/local/bin/paranoia && chmod +x /usr/local/bin/paranoia

echo 'Install loft'
curl -L -o loft https://github.com/loft-sh/loft/releases/latest/download/loft-linux-${BUILDARCH} && install -c -m 0755 loft /usr/local/bin

echo 'Install hadolint'
curl -L -o hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-${BUILDARCH} && cp hadolint /usr/local/bin/hadolint && chmod +x /usr/local/bin/hadolint

echo 'Install dive'
curl -L -o dive.deb https://github.com/wagoodman/dive/releases/download/v0.12.0/dive_0.12.0_linux_${BUILDARCH}.deb
apt install ./dive.deb

echo 'Install diun'
curl -L -o diun.tar.gz https://github.com/crazy-max/diun/releases/download/v4.28.0/diun_4.28.0_linux_${BUILDARCH}.tar.gz
tar -xvf diun.tar.gz
mv diun /usr/local/bin/

echo 'Install k9s'
curl -sS https://webi.sh/k9s | sh

echo 'Install kubectx'
curl -sS https://webi.sh/kubectx | sh

echo 'Install kubens'
curl -sS https://webi.sh/kubens | sh

echo 'Install helm-diff'
helm plugin install https://github.com/databus23/helm-diff --version v3.9.9

echo 'Install helm-secrets'
helm plugin install https://github.com/jkroepke/helm-secrets --version v4.6.1

echo 'Install trivy'
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin latest

echo 'Install syft'
curl -sSfL https://raw.githubusercontent.com/anchore/syft/main/install.sh | sh -s -- -b /usr/local/bin

echo 'Install minikube'
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-${BUILDARCH} && chmod +x minikube
cp minikube /usr/local/bin && rm minikube
