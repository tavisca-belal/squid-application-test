#!/bin/bash
apt-get update
apt-get install curl -y
export https_proxy=loadblanceradd

echo $https_proxy
cd /tmp

curl https://www.google.com >> /tmp/curloutput.txt

cat /tmp/curloutput.txt