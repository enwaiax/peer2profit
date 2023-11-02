FROM debian:bullseye-slim
LABEL org.opencontainers.image.authors="<chasing0806@gmail.com>" version="0.48"

WORKDIR /root
ENV PS1="\[\e[1;34m\]# \[\e[1;36m\]\u \[\e[1;0m\]@ \[\e[1;32m\]\h \[\e[1;0m\]in \[\e[1;33m\]\w \[\e[1;0m\][\[\e[1;0m\]\t\[\e[1;0m\]]\n\[\e[1;31m\]$\[\e[0m\] "

COPY peer2profit_0.48_amd64.deb entrypoint.sh /root/

RUN apt-get update && \
    apt-get install -y xvfb procps proxychains4 ./peer2profit_0.48_amd64.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ./peer2profit_0.48_amd64.deb

RUN mkdir -p /root/.config

CMD ["./entrypoint.sh"]
