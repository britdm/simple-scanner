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

## cluster setup instructions
### create k3d hosted registry
```
k3d registry create [registry-name] -p 0.0.0.0:[port] # optional port assignment
k3d registry list # get generated registry name
docker ps -f name=[registry-name] # find local port if not assigned
```

### setup k3d cluster
```
k3d cluster create [cluster-name] --use-registry [registry-name]
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
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest # rancher
helm repo add bitnami https://charts.bitnami.com/bitnami # mongodb
helm repo add rocketchat-server https://rocketchat.github.io/helm-charts # rocketchat
helm repo add anchore https://charts.anchore.io # anchore
helm repo update
```

## application deployment instructions
### install cert-manager
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.8.2 \
  --set installCRDs=true
```

### install docker-registry-ui
```