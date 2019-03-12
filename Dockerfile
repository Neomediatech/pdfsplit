FROM ubuntu:18.04

LABEL maintainer="docker-dario@neomediatech.it"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Rome

RUN apt-get update && apt-get install -y openssh-server poppler-utils qpdf ghostscript sudo cifs-utils && \ 
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
