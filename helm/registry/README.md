# docker registry
---
based off of [cluster registry](https://medium.com/swlh/deploy-your-private-docker-registry-as-a-pod-in-kubernetes-f6a489bf0180) and [docker-registry-ui](https://github.com/Joxit/docker-registry-ui)

commands use relative paths

## instructions
### deplpoy the registry an registry-ui
```
helm install docker-registry-ui joxit/docker-registry-ui \
  --namespace registry \
  --set registry.enabled=true
```

### create volume and persistentvolume
```
kubectl create -f registry-storage.yaml
```

### create cerificates
```
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout tls.key -out tls.crt -subj "/CN=docker-registry-ui-docker-registry-ui-registry-server" -addext "subjectAltName = DNS:docker-registry-ui-docker-registry-ui-registry-server"
```

```
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn myuser mypasswd > htpasswd
```

### add secrets to cluster
```
kubectl create secret tls certs-secret --cert=tls.crt --key=tls.key
kubectl create secret generic auth-secret --from-file=htpasswd
```

### add registry access to node hosts
```
kubectl-ssh node [node_name]

# inside container
echo '$[REGISTRY_IP] $[REGISTRY_NAME]' >> /etc/hosts


# for x in $(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }'); do ssh root@$x "rm -rf /etc/docker/certs.d/$REGISTRY_NAME:5000;mkdir -p /etc/docker/certs.d/$REGISTRY_NAME:5000"; done

# for x in $(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address }'); do scp /registry/certs/tls.crt root@$x:/etc/docker/certs.d


# exit container
```