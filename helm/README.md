# Install Helm Charts

Follow the instructions below to install each application using Helm.

## update charts
```
helm repo update
```

## cert-manager
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.8.2 \
  --set installCRDs=true
```

## rancher
```
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=me@example.org
```
### change rancher admin password
```
kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher | grep '1/1' | head -1 | awk '{ print $1 }') -- reset-password
```

## rocket-chat
```
# mongodb
helm install mongodb bitnami/mongodb \
   --namespace rocketchat

#rocketchat

```

## registry
```

```

## anchore
```

```