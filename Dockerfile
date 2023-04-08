FROM alpine:3.17

MAINTAINER Andrey Sorokin <andrey@sorokin.org>

RUN apk add wget ca-certificates unbound &&\
    mkdir -p /etc/unbound/unbound.conf.d &&\
    wget -S https://www.internic.net/domain/named.cache -O /etc/unbound/root.hints

COPY unbound.conf /etc/unbound/unbound.conf

EXPOSE 53/tcp
EXPOSE 53/udp

ENTRYPOINT ["/usr/sbin/unbound","-d"]

