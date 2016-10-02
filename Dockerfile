# Scylladb 1.3
#
# https://github.com/oscerd/scylladb-image

# Pull base image.
FROM ubuntu:16.04
RUN apt-get update \
    && apt-get install -y wget vim \
    && wget -O /etc/apt/sources.list.d/scylla.list http://downloads.scylladb.com/deb/ubuntu/scylla-1.3-xenial.list \
    && apt-get update && apt-get install -y scylla-server scylla-jmx scylla-tools --force-yes

USER root
COPY start-scylla /start-scylla
RUN  chown -R scylla:scylla /etc/scylla \
    && chown -R scylla:scylla /etc/scylla.d \
    && chown -R scylla:scylla /start-scylla

USER scylla
EXPOSE 10000 9042 9160 7000 7001
VOLUME /var/lib/scylla

CMD chmod +x start-scylla && /start-scylla


