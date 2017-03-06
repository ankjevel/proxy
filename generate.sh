#!/bin/bash

ENDPOINT=$([[ ! -z $ENDPOINT ]] && echo "$ENDPOINT" || echo "https://test.sh")

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
  server_tokens off;

  location / {
    proxy_pass $ENDPOINT;
    proxy_http_version 1.1;
    proxy_set_header Upgrade \$http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_set_header Host \$host;
  }
}
EOF
