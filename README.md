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
3. kubernetes binaries [x](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
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
5. rancher-cli [x](https://rancher.com/docs/rancher/v2.5/en/cli/)

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
- docker compose
- kubernetes libraries

### future goals:
1. Support offline deployments
2. Auto install via terraform or something similar
3. OpenStack integration
