### Unbound DNS resolver with TLS upstream

[Docker Hub Link](https://hub.docker.com/r/andrey0001/unbound-tls)

To hide your DNS requests to upstream provider you can use TLS for DNS. Not all software/equipment support tls for dns.
This container will help solve it, and improve your privacy.

**To build**:

> ```docker build . -t unbound-tls```

**To run**:

> ```docker run --name unbound-tls -p 53:53 -p 53:53/udp -d andrey0001/unbound-tls```

The container also looks for additional configs in /etc/unbound/unbound.conf.d , so you can attach volume and place your own files:
> ```docker run -v ./conf.d:/etc/unbound/unbound.conf.d  --name unbound-tls -p 53:53 -p 53:53/udp -d andrey0001/unbound-tls```

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

The container forward all requests with TLS to:
```
   1.0.0.1@853#one.one.one.one
   1.1.1.1@853#one.one.one.one
   8.8.4.4@853#dns.google
   8.8.8.8@853#dns.google
   9.9.9.9@853#dns.quad9.net
   149.112.112.112@853#dns.quad9.net
```

Enjoy!!!

PS: *Of course, you can make a compose file with PiHole and with an ip binding and get a ready-made solution, but at the moment I'm too lazy :-)*
