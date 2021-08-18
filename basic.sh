#!/bin/bash
apt-get update
apt-get install curl -y
echo 'export https_proxy=https://squid-poc.qa.oski.io:3444/' >> ~/.bashrc 


echo $https_proxy
cd /tmp

curl https://www.google.com >> /tmp/curloutput.txt

cat /tmp/curloutput.txt