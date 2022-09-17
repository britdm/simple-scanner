# docker registry
---
based off of concepts from [cluster registry](https://medium.com/swlh/deploy-your-private-docker-registry-as-a-pod-in-kubernetes-f6a489bf0180) and the [docker-registry-ui](https://github.com/Joxit/docker-registry-ui) project

commands use relative paths

## instructions
### setup registry
Pull down [brittanym/registry:1.0])(https://hub.docker.com/r/brittanym/registry), it includes a default `.htpasswd` file in `/auth/.htpasswd`.

Save login as kubernetes secret copy `.htpasswd` file to the local workspace from the image and create a generic auth-secret.

```kubectl create secret generic auth-secret --from=.htpasswd```

For the `tls.crt` and `tls.key` files, copy the to the local workspace from the image and create a tls certs-secret.

```kubectl create secret tls certs-secret --cert=tls.crt --key=tls.key```

### deplpoy the registry and registry-ui
```
helm install docker-registry-ui joxit/docker-registry-ui \
  --namespace registry \
  --set ui.dockerRegistryUrl=[registry_host]:[docker_host_port] # assigned registry port
```
