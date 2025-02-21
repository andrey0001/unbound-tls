### Unbound DNS resolver with TLS upstream

[Docker Hub Link](https://hub.docker.com/r/andrey0001/unbound-tls)

![Unbound](Unbound-DNS-logo.png)

Supported architecture:

- linux/amd64
- linux/arm/v7
- linux/arm64

To hide your DNS requests to upstream provider you can use TLS for DNS. Not all software/equipment support tls for dns.
This container will help solve it, and improve your privacy.

**To build**:

> ```docker build . -t unbound-tls```

**To run**:

> ```docker run --name unbound-tls -p 53:53 -p 53:53/udp -d andrey0001/unbound-tls```

or with compose:
```yaml
version: "3.8"
  unbound:
    image: andrey0001/unbound-tls:latest
    hostname: unbound-tls
    container_name: unbound-tls
    network_mode: bridge
    ports:
      - "53:53/tcp"
      - "53:53/udp"
    restart: unless-stopped
    volumes:
      - /opt/unbound-tls:/etc/unbound/unbound.conf.d
```
> ```docker-compose up -d```

The container also looks for additional configs in /etc/unbound/unbound.conf.d , so you can attach volume and place your own files:
> ```docker run -v ./conf.d:/etc/unbound/unbound.conf.d --name unbound-tls -p 53:53 -p 53:53/udp -d andrey0001/unbound-tls```

Example of "example.conf" file you could place in forder:
```
server:
 forward-zone:
   name: "example.com"
   forward-addr: 208.67.222.222
   forward-addr: 208.67.220.220
```

Also, the good idea to use it with [PiHole](https://github.com/pi-hole/docker-pi-hole). So, just change port for this container, then send all requests from PiHole to the port. As example:
> ```docker run --name unbound-tls -p 2253:53 -p 2253:53/udp -d andrey0001/unbound-tls```

Then use variable `PIHOLE_DNS_` when you start PiHole and set it to `IPADDRESS#2253`

***
#### **I also prepared compose file with PiHole "docker-compose-with-pihole.yaml" localed in this folder. You can edit and use it with docker-compose or portainer.**
> ```docker-compose -f docker-compose-with-pihole.yaml up -d``` 
***

The container forward all requests with TLS to:
```
   1.0.0.1@853#one.one.one.one
   1.1.1.1@853#one.one.one.one
   8.8.4.4@853#dns.google
   8.8.8.8@853#dns.google
   9.9.9.9@853#dns.quad9.net
   149.112.112.112@853#dns.quad9.net
```

Since ARM architecture also pushed to [Docker Hub](https://hub.docker.com/r/andrey0001/unbound-tls/tags), you could use container on [Mikrotik](https://mikrotik.com/) devices, supported on the latest version of RouterOS.

This branch ``s6`` based on s6-overlay, when master based on simple start.


Enjoy!!!



