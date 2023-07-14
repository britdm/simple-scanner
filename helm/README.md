# Install Helm Charts

Follow the instructions below to install each application using Helm.

## add helm charts

```
helm repo add harbor https://helm.goharbor.io
helm repo add bitnami https://charts.bitnami.com/bitnami # mongodb
helm repo add rocketchat-server https://rocketchat.github.io/helm-charts # rocketchat
helm repo update
```

## helm chart deployment

### install harbor

`./helm/harbor/README.md`


### install rocketchat

`./helm/rocketchat/README.md`