FROM hashicorp/envconsul:0.7.0-alpine

RUN set -x \
    && apk add --update libintl jq \
    && apk add --virtual build_deps gettext \
    && cp /usr/bin/envsubst /usr/local/bin/envsubst \
    && apk del build_deps \
    && rm -rf /var/cache/apk/* \
    && mkdir /env_config

COPY get_secrets.sh config.tmp.hcl /env_config/
RUN chmod +x /env_config/get_secrets.sh

CMD ["sh", "/env_config/get_secrets.sh"]