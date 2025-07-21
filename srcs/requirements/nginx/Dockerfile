FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY ./tools/nginx-config.conf /etc/nginx/nginx.conf

COPY ./tools/nginx-script.sh /nginx-script.sh
RUN chmod +x /nginx-script.sh

EXPOSE 443

CMD ["/nginx-script.sh"]
