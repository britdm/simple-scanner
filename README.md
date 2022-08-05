# simple-scanner

## required software packages
1. k3d [x](https://k3d.io/v5.4.4/#install-script)

2. docker [x](https://docs.docker.com/engine/install/ubuntu/)

3. kubectl [x](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
&nbsp;3a. kubectl-ssh plugin [x](https://github.com/luksa/kubectl-plugins/blob/master/kubectl-ssh)
&nbsp;&nbsp; ```curl -O https://github.com/luksa/kubectl-plugins/blob/master/kubectl-ssh```
&nbsp;&nbsp; ```chmod +x kubectl-ssh && sudo mv kubectl-ssh /usr/local/bin/kubectl-ssh```

4. helm [x](https://helm.sh/docs/intro/install/)

5. rancher-cli [x](https://rancher.com/docs/rancher/v2.5/en/cli/#download-rancher-cli)

### applications
- rancher
- rocketchat
- registry
- anchore

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
mkdir $HOME/.kube/
k3d kubeconfig get [cluster-name] > [$HOME]/.kube/config # may require full path
kubectl cluster-info
```

### deploy namespcaes
```
kubectl create -f helm/namespaces.yaml
```

### add helm charts
```
helm repo add jetstack https://charts.jetstack.io # cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.crds.yaml

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest # rancher

helm repo add bitnami https://charts.bitnami.com/bitnami # mongodb

helm repo add rocketchat-server https://rocketchat.github.io/helm-charts # rocketchat

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
  
helm install mongodb bitnami/mongodb \
   --namespace rocketchat

helm install \
    rocketchat rocketchat-server/rocketchat \
    --namespace rocketchat \ 
    --set mongodb.auth.password=$(echo -n $(openssl rand -base64 32)),mongodb.auth.rootPassword=$(echo -n $(openssl rand -base64 32))

helm install registry twuni/docker-registry --namespace registry
```

# rancher
## change rancher admin password
```
kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher | grep '1/1' | head -1 | awk '{ print $1 }') -- reset-password
```
## change rancher service type
```
kubectl patch svc rancher -n cattle-system -p '{"spec": {"type": "NodePort"}}'
```
