FROM postgres:9.5

MAINTAINER Micke Lisinge

# Install postgis
ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.2+dfsg-1.pgdg80+1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION

# Install wal-e
RUN apt-get update && apt-get install -y python-pip python-dev lzop pv daemontools
RUN pip install wal-e

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD fix-acl.sh /docker-entrypoint-initdb.d/
ADD setup-wale.sh /docker-entrypoint-initdb.d/
