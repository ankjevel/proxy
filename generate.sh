#!/bin/bash
ENDPOINT=$(echo ${ENDPOINT:-"https://test.sh"} | sed -e 's/\/+$//')

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
  server_tokens off;
  charset UTF-8;

  location / {
    proxy_connect_timeout 5m;
    proxy_send_timeout    5m;
    proxy_read_timeout    5m;
    send_timeout          5m;
    rewrite               /(.*)/\$  /\$1;
    proxy_pass            $ENDPOINT/;
  }
}
EOF
