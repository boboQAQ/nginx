FROM nats:2.3-alpine
COPY nats-server.conf /nats/conf/nats-server.conf
EXPOSE 4222
CMD ["/usr/local/bin/nats-server", "-c", "/nats/conf/nats-server.conf"]