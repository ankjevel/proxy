#!/bin/bash
TIMEOUT=${TIMEOUT:-"1m"}
ENDPOINT=$(echo ${ENDPOINT:-"https://test.sh"} | sed -e 's/\/+$//')

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
  server_tokens         off;
  charset               utf-8;

  location / {
    proxy_connect_timeout $TIMEOUT;
    proxy_send_timeout    $TIMEOUT;
    proxy_read_timeout    $TIMEOUT;
    send_timeout          $TIMEOUT;
    proxy_http_version    1.1;
    proxy_set_header      Connection "";
    rewrite               /(.*)/\$  /\$1;
    proxy_pass            $ENDPOINT/;
  }
}
EOF
