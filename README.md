#Nginx Load Balancer With Consul Template

Dockerfile for Nginx load balancer with upstream automatic update using Consul Template

## Use Docker HUB images
You can pull laatest built image from  DockerHub:

```
docker pull cloudhero/nginx-proxy
```

Run image:

```
docker run -it -e "CONSUL=$DOCKER_IP:8500" -e "SERVICE=queryname" -p 80:80 cloudhero/nginx-proxy
```

CONSUL is the IP address of your Consul service, SERVICE is the query sent to consul which will be distributed across.


## Build your own image

Build with:

```
docker build -t nginx-proxy .
```

Run with:

```
docker run -it -e "CONSUL=$DOCKER_IP:8500" -e "SERVICE=queryname" -p 80:80 nginx-proxy
```

`CONSUL` is the IP address of your Consul service, `SERVICE` is the query sent to consul which will be distributed across.

##Customise nginx template

You can update `nginx-vhost.conf.ctmpl`  based on your needs as loong as you keep the same query parameters.

## Known Issues
Currently this image has been tested and works well with Consul Template version 0.5.1
Latest version of Consul Template returs `{{.Address}}` query from `{{.ServiceAddress}}` which provides wrong upstream IP address


# Read more [here](https://cloudhero.io/blog)
References: [here](http://www.maori.geek.nz/post/scalable_architecture_dr_con_docker_registrator_consul_nginx)
