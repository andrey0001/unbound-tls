ARG ARCH=
FROM ${ARCH}alpine:3.19
# docker buildx build --push --platform linux/arm/v7,linux/arm64/v8,linux/amd64 --tag andrey0001/unbound-tls .

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

RUN apk add --no-cache wget ca-certificates unbound &&\
    mkdir -p /etc/unbound/unbound.conf.d &&\
    wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

COPY unbound.conf /etc/unbound/unbound.conf

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/unbound","-d"]


