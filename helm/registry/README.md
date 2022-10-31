# docker registry
---
Includes the [docker-registry-ui](https://github.com/Joxit/docker-registry-ui) project.

## instructions
### assumptions
- the intended kubernetes cluster is not a production cluster
### setup registry
Pull down [brittanym/registry:2.0])(https://hub.docker.com/r/brittanym/registry) from Docker Hub, it includes a default `.htpasswd` file in `/auth/.htpasswd`. Start up a detached container. sSave a copy of the `tls.crt` and `tls.key` files to be used as desired.

#### unsupported kubernetes setup
Save the login as a kubernetes secret by first copying the htpasswd file into the local workspace from the image and the creating a generic Kubernetes auth-secret.

```kubectl create secret generic auth-secret --from=.htpasswd```

For the `tls.crt` and `tls.key` files, copy the to the local workspace from the image and create a tls certs-secret.

```kubectl create secret tls certs-secret --cert=tls.crt --key=tls.key```

### deplpoy the registry-ui
```
helm install docker-registry-ui joxit/docker-registry-ui \
  --namespace registry \
  --set ui.dockerRegistryUrl=[registry_host]:[docker_host_port] # assigned registry port
```
