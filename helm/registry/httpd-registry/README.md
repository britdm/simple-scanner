# registry
version 1.0

## quickstart
Setup local private registry.
```
    docker run -p 5000:5000 --rm --name registry --user admin \ 
    -e "REGISTRY_AUTH=htpasswd" -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
    -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/.htpasswd \
    -e "REGISTRY_HTTP_HEADERS_Access-Control-Allow-Origin=[\'*\']" \
    -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
    -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key brittanym/registry:1.0
```

### login information
The authorization file was created using htpasswd. The default login can be changed by overwriting the `/auth/.htpasswd` entry for the default admin user. Use `docker login` to authenticate with the registry username `admin` password `admin123`. The assumption is that there is not another docker user logged into the system where the registry is deployed.

Login:
```docker login localhost:5000 -u admin```

(Optional) Overwrite or replace `/auth/.htpasswd` file using:
```htpasswd -Bbn admin [new_password] > /auth/.htpasswd```
To add another user replace `>` with `>>` and replace `admin` with the new username.

## Squid Proxy Setup
<mark>This application is not yet supported.</mark>
Using the docker-registry-cache repository may be a solution to satisfy secure registry requirements for the docker-registry-ui
