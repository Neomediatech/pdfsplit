FROM neomediatech/ubuntu-base:latest

ENV VERSION=18.04 \
    SERVICE=pdfsplit

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

RUN apt-get update && apt-get install -y openssh-server poppler-utils qpdf ghostscript sudo cifs-utils && \ 
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh 

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
