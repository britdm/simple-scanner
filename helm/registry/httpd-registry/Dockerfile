FROM httpd:2.4 as builder
WORKDIR /
RUN apt-get update
RUN mkdir auth && mkdir certs \
    && htpasswd -c root admin123 >> /auth/.htpasswd \
    && openssl req -x509 -sha256 -nodes -days 365 \
     -newkey rsa:4096 -keyout /certs/registry.key -out /certs/registry.crt \
     -subj "/C=US/ST=Texas/L=Austin/O=Company/CN=www.example.com"

FROM registry:2
RUN apk update
COPY . /
COPY --from=builder /auth/.htpasswd /auth/.htpasswd
COPY --from=builder /certs/registry.key /certs/registry.key
COPY --from=builder /certs/registry.crt /certs/registry.crt
