# rancher
## deploy rancher
```
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.my.org \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=me@example.org
```

## change rancher admin password
```
kubectl -n cattle-system exec $(kubectl -n cattle-system get pods -l app=rancher | grep '1/1' | head -1 | awk '{ print $1 }') -- reset-password
```
## change rancher service type
```
kubectl patch svc rancher -n cattle-system -p '{"spec": {"type": "NodePort"}}'
```