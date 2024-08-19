#!/bin/bash

OIDC_ISSUER_URL=$1
BASE_URL=${OIDC_ISSUER_URL#https://}
BASE_URL=${BASE_URL%%/*}  # Extract base domain

THUMBPRINT=$(echo | \
 openssl s_client -servername $BASE_URL \
 -showcerts -connect $BASE_URL:443 2>/dev/null | \
 openssl x509 -fingerprint -noout -sha1 | \
 awk -F'=' '{ print $2 }' | tr -d ':')

if [[ ${#THUMBPRINT} -eq 40 ]]; then
 jq -n --arg thumbprint "$THUMBPRINT" '{"thumbprint":$thumbprint}'
else
 echo "Failed to fetch the thumbprint" >&2
 exit 1
fi