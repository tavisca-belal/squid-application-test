# Squid Proxy Https in application level 

To test inside the Docker container we need to create a Docker setup with curl inside:
## Docker

```
docker build . -t httpscert
```
Once the docker build image we can then run it by using the command 

```
docker run https curl https://www.google.com
```
#### Output
```
[root@ip-10-233-42-64 squid-application-test]# docker run https curl -v https://www.google.com
* Rebuilt URL to: https://www.google.com/
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 34.237.11.183...
* TCP_NODELAY set
* Connected to squid-poc.qa.oski.io (34.237.11.183) port 3444 (#0)
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
} [5 bytes data]
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
} [512 bytes data]
* TLSv1.3 (IN), TLS handshake, Server hello (2):
{ [81 bytes data]
* TLSv1.2 (IN), TLS handshake, Certificate (11):
{ [943 bytes data]
* TLSv1.2 (IN), TLS handshake, Server finished (14):
{ [4 bytes data]
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
} [262 bytes data]
* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
} [1 bytes data]
* TLSv1.2 (OUT), TLS handshake, Finished (20):
} [16 bytes data]
* TLSv1.2 (IN), TLS handshake, Finished (20):
{ [16 bytes data]
* SSL connection using TLSv1.2 / AES256-GCM-SHA384
* ALPN, server did not agree to a protocol
* Proxy certificate:
*  subject: C=IN; ST=MH; L=PUNE; O=Tavisca; OU=IT; CN=squid-poc.qa.oski.io
*  start date: Aug  5 18:20:22 2021 GMT
*  expire date: Aug  5 18:20:22 2022 GMT
*  common name: squid-poc.qa.oski.io (matched)
*  issuer: C=IN; ST=MH; L=PUNE; O=Tavisca; OU=IT; CN=squid-poc.qa.oski.io
*  SSL certificate verify ok.
* allocate connect buffer!
* Establish HTTP proxy tunnel to www.google.com:443
} [5 bytes data]
> CONNECT www.google.com:443 HTTP/1.1
> Host: www.google.com:443
> User-Agent: curl/7.58.0
> Proxy-Connection: Keep-Alive
```
Squid Proxy Server Response 
From /var/log/squid/access.log
```
19/Aug/2021:15:19:42 +0000 1629386382.061 1629386381.994     68 34.198.68.243 TCP_TUNNEL/200 19629 CONNECT www.google.com:443 - HIER_DIRECT/172.217.1.196 - -

```
Adding the proxy command to check:

```
docker run httpscert2 curl -v --proxy https://squid-poc.qa.oski.io:3444 https://www.google.com
```
#### Output

```
[root@ip-10-233-42-64 squid-application-test]# docker run https curl -v --proxy https://squid-poc.qa.oski.io:3444 https://www.google.com
* Rebuilt URL to: https://www.google.com/
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 34.237.11.183...
* TCP_NODELAY set
* Connected to squid-poc.qa.oski.io (34.237.11.183) port 3444 (#0)
* ALPN, offering http/1.1* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt  CApath: /etc/ssl/certs} [5 bytes data]* TLSv1.3 (OUT), TLS handshake, Client hello (1):} [512 bytes data]* TLSv1.3 (IN), TLS handshake, Server hello (2):{ [81 bytes data]
* TLSv1.2 (IN), TLS handshake, Certificate (11):{ [943 bytes data]* TLSv1.2 (IN), TLS handshake, Server finished (14):
{ [4 bytes data]
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):} [262 bytes data]* TLSv1.2 (OUT), TLS change cipher, Client hello (1):} [1 bytes data]
* TLSv1.2 (OUT), TLS handshake, Finished (20):
} [16 bytes data]* TLSv1.2 (IN), TLS handshake, Finished (20):{ [16 bytes data]* SSL connection using TLSv1.2 / AES256-GCM-SHA384* ALPN, server did not agree to a protocol
* Proxy certificate:
*  subject: C=IN; ST=MH; L=PUNE; O=Tavisca; OU=IT; CN=squid-poc.qa.oski.io
*  start date: Aug  5 18:20:22 2021 GMT
*  expire date: Aug  5 18:20:22 2022 GMT
*  common name: squid-poc.qa.oski.io (matched)
*  issuer: C=IN; ST=MH; L=PUNE; O=Tavisca; OU=IT; CN=squid-poc.qa.oski.io
*  SSL certificate verify ok.
* allocate connect buffer!
* Establish HTTP proxy tunnel to www.google.com:443
} [5 bytes data]
> CONNECT www.google.com:443 HTTP/1.1
> Host: www.google.com:443
> User-Agent: curl/7.58.0
> Proxy-Connection: Keep-Alive
```

Squid Proxy Server Response 
From /var/log/squid/access.log
```
19/Aug/2021:15:21:18 +0000 1629386478.401 1629386478.339     61 34.198.68.243 TCP_TUNNEL/200 19693 CONNECT www.google.com:443 - HIER_DIRECT/172.217.1.196 - 1
```


