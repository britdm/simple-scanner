# simple-scanner

## required software packages

1. k3s [x](https://docs.k3s.io/quick-start)

2. docker [x](https://docs.docker.com/engine/install/ubuntu/)

3. kubectl [x](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)

4. helm [x](https://helm.sh/docs/intro/install/)

### applications

- rocketchat (or slack)
- harbor w/trivy

### future goals

1. Install k3s with podman instead of docker
2. Support offline deployment
3. Link harbor with rocketchat

## cluster setup instructions

### WSL (Ubuntu) setup

This setup was tested using WSL with Ubuntu on Windows 11.

- install all required software packages
- copy `/etc/rancher/k3s/k3s.yaml` to `~/.kube/config`
- verify `kubectl` can access the cluster

### create namespcaes

```
kubectl create ns harbor && kubectl create ns rocketchat
```

### install helm charts

Follow the instructions found in `./helm/README.md`
