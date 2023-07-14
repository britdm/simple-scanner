# rocketchat

<mark>This application is not yet supported and the command to install has not been updated.</mark>

## instructions

### helm chart

```
helm install rocketchat rocketchat/rocketchat \
---namespace rocketchat \
--set mongodb.auth.password=$(echo -n $(pwgen 20 1)),mongodb.auth.rootPassword=$(echo -n $(pwgen 20 1))
```