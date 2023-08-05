# simple-scanner (alpha)

This repository is project that allows for building and scanning images locally. This project is in the **alpha** stage and should *not* be deployed into production environments since it uses insecure tools, like the default docker registry. This deployment should be able to run offline after the trivy vulnerability data base in loaded, future support will include offline deployment.

## Docker Compose

There is a default `docker-compose.yaml` file included in this repository that is ready to deploy. The file can be modified or updated to include any custom changes.

### services

1. registry - based on [Docker Registry UI](https://github.com/Joxit/docker-registry-ui#recommended-docker-registry-usage)

2. mattermost-preview - [x](https://hub.docker.com/r/mattermost/mattermost-preview)

3. trivy - [built](https://hub.docker.com/r/brittanym/trivy) from [Alpine trivy](https://pkgs.alpinelinux.org/package/edge/testing/x86/trivy)

### deploy

To deploy this alpha setup using docker compose run `docker compose up -d`. Note that `docker-compose` is not used in this case.

### usage

Tag images with the `localhost:5000` registry and push to the registry after the deployment is up and running.

Inside of the trivy container run `trivy image localhost:5000/<image-name>:<image-tag> --insecure` to scan the image for vulnerabilities. To view other trivy capabilities simply run `trivy` or `trivy --help`.

## Kubernetes [not tested]

### required software packages

1. k3s [x](https://docs.k3s.io/quick-start)

2. docker [x](https://docs.docker.com/engine/install/ubuntu/)

3. kubectl [x](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management)

4. helm [x](https://helm.sh/docs/intro/install/)

#### applications

- mattermost
- trivy
- docker registry

### future goals

1. Install k3s with podman instead of docker
2. Support offline kubernetes deployment
3. Link mattermost to trivy using cronjobs or listeners
4. Switch to using a secure docker registry

### cluster setup instructions

#### WSL (Ubuntu) setup

This setup was tested using WSL with Ubuntu on Windows 11.

- install all required software packages
- copy `/etc/rancher/k3s/k3s.yaml` to `~/.kube/config`
- verify `kubectl` can access the cluster

#### create namespcaes

Created namesapces called `trivy`, `mattermost`, and `registry`

```
kubectl create ns <NAMESPACE>
```

#### install helm charts

Follow the instructions found in `./helm/helm.md`
