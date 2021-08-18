FROM ubuntu
COPY ./basic.sh /tmp
RUN chmod +x /tmp/basic.sh
CMD ["sh", "/tmp/basic.sh"]
#CMD ["cat", "/tmp/curloutput.txt"]