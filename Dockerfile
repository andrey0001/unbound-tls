ARG ARCH=
FROM ${ARCH}alpine:3.17
# docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag andrey0001/unbound-tls .

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

RUN apk add --no-cache wget ca-certificates unbound s6-overlay &&\
    mkdir -p /etc/unbound/unbound.conf.d &&\
    wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

COPY docker/services.d /etc/services.d

COPY unbound.conf /etc/unbound/unbound.conf

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["/init"]

