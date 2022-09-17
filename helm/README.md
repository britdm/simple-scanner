# Install Helm Charts
Follow the instructions below to install each application using Helm.

## add helm charts
```
helm repo add jetstack https://charts.jetstack.io # cert-manager
helm repo add bitnami https://charts.bitnami.com/bitnami # mongodb
helm repo add rocketchat-server https://rocketchat.github.io/helm-charts # rocketchat
helm repo add anchore https://charts.anchore.io # anchore
helm repo update
```

## application deployment instructions
### install cert-manager
`./helm/cert-manager/README.md`

### install registry
`./helm/registry/README.md`

### install docker-registry-ui
`./helm/registry/README.md`

### install rocketchat
`./helm/rocketchat/README.md`

### install anchore/grype
`./helm/anchore/README.md`