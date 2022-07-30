# simple-scanner

## required software packages
1. kubernetes cluster [k3s - Lightweight Kubernetes](https://k3s.io/)
```
> curl -sfL https://get.k3s.io | sh -
```
2. docker [x](https://docs.docker.com/engine/install/ubuntu/)
```
> sudo apt install -y docker.io # ubuntu should already have the Docker CLI tool installed.
```
3. kubectl [x](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
```
> curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
> sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl # follow instructions for install with non-root access
```
4. helm [x](https://helm.sh/docs/intro/install/)
```
> curl -LO https://get.helm.sh/helm-v3.9.0-linux-amd64.tar.gz
> tar -xf helm-v3.9.0-linux-amd64.tar.gz
> sudo mv linux-amd64/helm /usr/local/bin/helm
> rm -rf helm-v3.9.0-linux-amd64.tar.gz linux-amd64/
```
5. rancher-cli [x](https://rancher.com/docs/rancher/v2.5/en/cli/#download-rancher-cli)

6. k3d [x](https://k3d.io/v5.4.4/#install-script)
```
> curl https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

### applications
- rancher
- rocket chat
- registry
- anchore
- jira service desk (not yet implemented)

### namespaces
Apply the `namespaces.yaml` to the cluster before using `helm/README.md` to install the applications.

### software packages
- rancher cli
- helm
- docker
- docker compose (optional)
- kubectl
- k3d

### future goals:
1. Support offline deployments
2. Auto install via terraform or something similar
3. OpenStack integration
4. Staged registries

## instructions

### setup k3d cluster
```
k3d cluster create [cluster-name]
```

### save kubeconfig of cluster
Ensure that the KUBECONFIG variable is pointing to the correct file.
```
k3d kubeconfig get [cluster-name] > /home/brittany/.kube/config
kubectl cluster-info
```

### deploy namespcaes
```
kubectl create -f namespaces.yaml
```

### add helm charts
```
helm repo add jetstack https://charts.jetstack.io # cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.crds.yaml

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest # rancher

helm repo add rocketchat https://rocketchat.github.io/helm-charts # rocketchat

helm repo add twuni https://helm.twun.io # registry

helm repo add anchore https://charts.anchore.io # anchore

helm repo update
```

# install charts
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.8.2 \
  --set installCRDs=true

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=me@example.org

helm install \
    rocketchat rocketchat/rocketchat \
    --namespace rocketchat \ 
    --set mongodb.auth.password=$(echo -n $(openssl rand -base64 32)),mongodb.auth.rootPassword=$(echo -n $(openssl rand -base64 32))

helm install registry twuni/docker-registry --namespace registry
```

# change rancher admin password
```
kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher | grep '1/1' | head -1 | awk '{ print $1 }') -- reset-password
```
