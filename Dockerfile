FROM nginx:latest
MAINTAINER andrei@cloudhero.io

RUN apt-get update -qq && apt-get -y install wget unzip
RUN rm -rf /var/lib/apt/lists/*
RUN rm /etc/nginx/conf.d/*

#Consul template version and download URL
ENV CT_VERS 0.5.1
ENV CT_URL https://releases.hashicorp.com/consul-template/0.5.1/consul-template_$CT_VERS_linux_amd64.zip

#Default nginx and consul configuration files
ENV CT_FILE /etc/consul-templates/nginx-vhost.conf
ENV NX_FILE /etc/nginx/conf.d/nginx-vhost.conf

#Install Consul Template
RUN wget $CT_URL && \
    unzip -d /usr/local/bin consul-template_$CT_VERS_linux_amd64.zip

#Setup Consul Template Files
RUN mkdir /etc/consul-templates
COPY nginx-vhost.conf.ctmpl $CT_FILE

ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 80 443
ENTRYPOINT ["/entrypoint.sh"]
