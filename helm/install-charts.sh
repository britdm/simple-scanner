#!/bin/sh

export KUBECONFIG=~/.kube/config

# Download charts
# helm pull --version v1.5.1 jetstack/cert-manager
# helm pull joxit/docker-registry-ui
# helm pull rocketchat-server/rocketchat
# helm pull rancher-latest/rancher
# helm pull bitnami/mongodb

# Install Helm Charts for Applications
# Rancher
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
wget https://github.com/cert-manager/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml
k3s kubectl apply -f cert-manager.crds.yaml
rm cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.5.1
helm install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set replicas=3
kubectl -n cattle-system rollout status deploy/rancher

# Rocket Chat
helm install --set \
 mongodb.mongodbUsername=rocketchat,mongodb.mongodbPassword=changeme,mongodb.mongodbDatabase=rocketchat,mongodb.mongodbRootPassword=root-changeme \
 my-rocketchat stable/rocketchat --namespace rocket-chat

# Registry
helm repo add joxit https://helm.joxit.dev
helm install docker-registry-ui joxit/docker-registry-ui \
  --namespace registry \
  --set registry.enabled=true

# Anchore
helm repo add anchore https://charts.anchore.io
helm install my-release anchore/anchore-engine --namespace anchore
