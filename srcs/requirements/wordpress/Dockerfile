FROM debian:bookworm

ENV DOMAIN_NAME=${DOMAIN_NAME}
ENV WP_DATABASE_NAME=${WP_DATABASE_NAME}
ENV WP_ADMIN=${WP_ADMIN}
ENV WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}
ENV WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ENV WP_USER=${WP_USER}
ENV WP_USER_PASSWORD=${WP_USER_PASSWORD}
ENV WP_USER_EMAIL=${WP_USER_EMAIL}

RUN apt-get update -y && \
    apt-get -y install php8.2 php-fpm php-mysql mariadb-client wget curl sendmail && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -f www-data && useradd -g www-data www-data || true

RUN mkdir -p /run/php

COPY /tools/www.conf /etc/php/8.2/fpm/pool.d
COPY /tools/wordpress-script.sh /

RUN chmod +x /wordpress-script.sh

EXPOSE 9000

CMD ["/wordpress-script.sh"]
