#!/bin/bash

ENDPOINT=$([[ ! -z $ENDPOINT ]] && echo "$ENDPOINT" || echo "https://test.sh")
ENDPOINT=$(echo $ENDPOINT | sed -e 's/\/+$//')

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
  server_tokens off;
  charset UTF-8;

  location / {
    rewrite /(.*)/\$ /\$1;
    proxy_pass $ENDPOINT/;
  }
}
EOF
