FROM debian:11-slim
LABEL org.opencontainers.image.authors="<chasing66@live.com>" version="0.56"
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates procps proxychains4 \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
WORKDIR /root
COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x entrypoint.sh
COPY p2pclient /usr/bin/p2pclient
RUN chmod +x /usr/bin/p2pclient
VOLUME [ "/root/.config" ]
ENTRYPOINT ["/root/entrypoint.sh"]
