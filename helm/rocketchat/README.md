# rocketchat
## instructions
### install helm chart(s)
```
helm install rocketchat rocketchat/rocketchat \
---namespace rocketchat \
--set mongodb.auth.password=$(echo -n $(pwgen 20 1)),mongodb.auth.rootPassword=$(echo -n $(pwgen 20 1))
```