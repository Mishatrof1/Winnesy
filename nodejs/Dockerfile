ARG LARADOCK_NODE_VERSION=latest
FROM node:${LARADOCK_NODE_VERSION}-alpine

LABEL maintainer="Huadong Zuo <admin@zuohuadong.cn>"

RUN apk --no-cache add tzdata ca-certificates && npm install pm2@latest -g

WORKDIR /var/www/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
