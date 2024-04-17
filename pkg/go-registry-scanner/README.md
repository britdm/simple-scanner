# go-registry-scanner

The module was created to scan an insecure private Docker registry at `localhost:5000` with basic authentication. This is the default authentication used in `brittanym/registry:2.0` which can be pulled from [Docker Hub](https://hub.docker.com/r/brittanym/registry), follow the instructions shown there to modify the `.htpasswd` file.

## quick start
Clone this repository.

### go
- In the local directory build the module `go build`
- To add the module to the `$GOPATH/bin` run `go install`, this will build and move the module in a single step

### python
- see the [registry-scanner-python](https://github.com/britdm/http-registry-scanner-python) project

### docker
- Use the Dockerfile to build the registry-scanner Docker image with customized modifications or pull it from [Docker Hub](https://hub.docker.com/r/brittanym/registry-scanner/tags)

## future goals
- Enable input for variables `registry url`, `username`, and `password`.
- Binary files to simplify installation and use of the scanner.
