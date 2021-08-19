FROM ubuntu:18.04
RUN apt-get update ; apt-get install -y curl
RUN apt-get install ca-certificates -y
COPY ./squidCA.crt /usr/local/share/ca-certificates/squidCA.crt
RUN chmod 644 /usr/local/share/ca-certificates/squidCA.crt && update-ca-certificates
ENV http_proxy "https://squid-poc.qa.oski.io:3444"
ENV https_proxy "https://squid-poc.qa.oski.io:3444"
