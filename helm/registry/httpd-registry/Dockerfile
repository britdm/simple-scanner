FROM httpd:2.4 as builder
WORKDIR /
RUN apt-get update
RUN mkdir certs \
    && openssl req -x509 -sha256 -nodes -days 365 \
     -newkey rsa:4096 -keyout /certs/registry.key -out /certs/registry.crt \
     -subj "/C=US/ST=Texas/L=Austin/O=Company/CN=www.example.com"

FROM registry:2.7.0
RUN apk update
COPY . /
COPY --from=builder /certs/registry.key /certs/registry.key
COPY --from=builder /certs/registry.crt /certs/registry.crt
RUN adduser -D -H admin -G root \
    && mkdir auth \
    && mkdir -p /var/lib/registry \
    && htpasswd -Bbn admin admin123 >> /auth/.htpasswd \
    && chown -R admin: /var/lib/registry \
    && chown -R admin: /auth \
    && chown -R admin: /certs
USER admin