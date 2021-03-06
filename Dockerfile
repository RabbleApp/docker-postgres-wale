FROM postgres:9.5.4

MAINTAINER Micke Lisinge

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.2+dfsg-4.pgdg80+1

# Update apt
RUN apt-get update

# Install postGIS
RUN apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION

# Install wal-e
RUN apt-get install -y python-pip python-dev lzop pv daemontools
RUN pip install --upgrade --force pip
RUN pip install wal-e

# Install supervisord
RUN apt-get install -y supervisor
ADD supervisord.conf /supervisord.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD fix-acl.sh /docker-entrypoint-initdb.d/
ADD setup-wale.sh /docker-entrypoint-initdb.d/

ADD wal-entrypoint.sh /wal-entrypoint.sh

ENTRYPOINT []
CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
