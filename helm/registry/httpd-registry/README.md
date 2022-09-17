# registry
version 1.0

## quickstart
Setup local private registry.
```docker run -p 5000:5000 brittanym/registry:1.0```

### login information
The authorization file was created using htpasswd. The default login can be changed by overwriting the `/auth/.htpasswd` entry for the default admin user. Use `docker login` to authenticate with the registry username `admin` password `admin123`.

Log in:
```docker login localhost:5000```

(Optional) Overwrite or replace `/auth/.htpasswd` file using:
```htpasswd -c admin [new_password] > /auth/.htpasswd```

## Squid Proxy Setup
<mark>This application is not yet supported.</mark>
Using the docker-registry-cache repository may be a solution to satisfy secure registry requirements for the docker-registry-ui
