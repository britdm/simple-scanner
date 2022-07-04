#!/bin/sh

# Setup Cluster Access
sudo mkdir ~/.kube/config
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

# Install Helm Charts for Applications
# Rancher
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml
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
helm repo add twuni https://helm.twun.io
helm install twuni/docker-registry --namespace registry

# Anchore
helm repo add anchore https://charts.anchore.io
helm install my-release anchore/anchore-engine --namespace anchore

# Jira Service Management - TBD
