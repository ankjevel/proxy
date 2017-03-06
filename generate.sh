#!/bin/bash

ENDPOINT=$([[ ! -z $ENDPOINT ]] && echo "$ENDPOINT" || echo "https://test.sh")
ENDPOINT=$(echo $ENDPOINT | sed -e 's/\/+$//')

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
  server_tokens off;

  location / {
    rewrite /(.*)/\$ /\$1;
    proxy_buffering off;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_pass $ENDPOINT/;
  }
}
EOF
