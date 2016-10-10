#!/usr/bin/env bash

# Check we've got an email address
if [ -z "${DOMAINS}" ]; then
    echo -e "\n\033[31mYou must provide the \$DOMAINS variable with a space separated list of domains to get the SSL certificates for\033[0m\n"
    exit 1
fi

# Check we've agrees the Terms of Service
if [ -z "${AGREE_TOS}" ] || [ "${AGREE_TOS}" != "yes" ]; then
    echo -e "\n\033[31mYou must agree the Terms of Service by setting the \$AGREE_TOS environment variable to yes\033[0m\n"
    exit 1
fi

# Check we've got an email address
if [ -z "${LETSENCRYPT_EMAIL}" ]; then
    echo -e "\n\033[31mYou must provide the \$LETSENCRYPT_EMAIL variable to receive notifications regarding certificates\033[0m\n"
    exit 1
fi

DOMAIN_ARGS=`sed "s/ / -d /g" <<<"$DOMAINS"`

# Override the default site with the letsencrypt basic on
if [ -f /etc/nginx/sites-enabled/default.conf ]
then
    rm /etc/nginx/sites-enabled/default.conf
fi
ln -s /etc/nginx/sites-available/setup-certs.conf /etc/nginx/sites-enabled/default.conf

mkdir -p ${WEBROOT}

CERTBOT_STAGING=${CERTBOT_STAGING:+--staging}

nginx

echo "certbot certonly --non-interactive --agree-tos --email ${LETSENCRYPT_EMAIL}  --expand ${CERTBOT_STAGING} --webroot \
    -w ${WEBROOT} -d ${DOMAIN_ARGS}"

certbot certonly --non-interactive --agree-tos --email ${LETSENCRYPT_EMAIL}  --expand ${CERTBOT_STAGING} --webroot \
    -w ${WEBROOT} -d ${DOMAIN_ARGS}