# simple-scanner

## prerequisites
1. kubernetes cluster
2. docker
3. kubernetes binaries
4. helm

### applications
- rancher
- rocket chat
- registry
- anchore/twistlock
- fortify (not yet implemented)
- jira service desk (not yet implemented)

### namespaces
Apply the `namespaces.yaml` to the cluster before using `helm/install-charts.sh` to install the applications.

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
