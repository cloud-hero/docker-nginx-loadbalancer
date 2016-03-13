#!/bin/bash

if [ -z "$SERVICE" ]; then
        echo "Please add your Service Tag"
        exit
   else
        sed 's|{{range service "replaceme"}}|{{range service "'$SERVICE'"}}|' -i $CT_FILE
fi

/usr/sbin/nginx -c /etc/nginx/nginx.conf \
& CONSUL_TEMPLATE_LOG=debug consul-template \
  -consul=$CONSUL \
  -template "$CT_FILE:$NX_FILE:/usr/sbin/nginx -s reload";
