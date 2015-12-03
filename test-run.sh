#!/bin/bash
#
# Simple test script to test the SSL proxy
# Point https://www.ssllabs.com/ssltest/ at your site 
#    to see if it works as expected
#

# docker image to launch
IMAGE_NAME=eucm/nginx-ssl-proxy

# where to find server keys
KEYS_DIR="$(pwd)/testsecrets/keys"

# service that will be proxied through this proxy
SERVER_NAME=gin.fdi.ucm.es:3000

docker run \
  -p 80:80 \
  -p 443:443 \
  -e ENABLE_SSL=true \
  -e ENABLE_BASIC_AUTH=false \
  -e TARGET_SERVICE=${SERVER_NAME} \
  -v ${KEYS_DIR}/public.crt:/etc/secrets/proxycert \
  -v ${KEYS_DIR}/private.key:/etc/secrets/proxykey \
  -v ${KEYS_DIR}/dh2048.pem:/etc/secrets/dhparam \
    ${IMAGE_NAME}