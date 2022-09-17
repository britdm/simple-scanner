# docker registry
<mark>This file is out of date.</mark>
---
based off of [cluster registry](https://medium.com/swlh/deploy-your-private-docker-registry-as-a-pod-in-kubernetes-f6a489bf0180) and [docker-registry-ui](https://github.com/Joxit/docker-registry-ui)

commands use relative paths

## instructions
### deplpoy the registry an registry-ui
```
helm install docker-registry-ui joxit/docker-registry-ui \
  --namespace registry \
  --set ui.dockerRegistryUrl=localhost:[port] # assigned registry port
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
to get node name: `kubectl get nodes`
to get node IP: `kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="InternalIP")].address}'`

```
kubectl-ssh node [node_name]

# inside container
echo '$[REGISTRY_IP] $[REGISTRY_NAME]' >> /etc/hosts

rm -rf /etc/docker/certs.d/$REGISTRY_NAME:5000 # if exists
mkdir -p /etc/docker/certs.d/$REGISTRY_NAME:5000

vi tls.crt
# copy cert data into file maually with pbcopy, clip, etc.

cat > /etc/rancher/k3s/registries.yaml <<EOF
mirrors:
  "10.43.38.241:5000":
    endpoint:
      - "http://10.43.38.241:5000"
EOF

# exit container
```

### restart k3s
 * using kubelet
 * hard reboot machine
 * restart remote server

 ### login to registry on master node
 