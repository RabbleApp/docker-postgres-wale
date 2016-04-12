# Postgres docker container with postGIS and wal-e

Based on https://github.com/docker-library/postgres with postGIS and [WAL-E](https://github.com/wal-e/wal-e) installed.

Environment variables to pass to the container for postgres.

`POSTGRES_USER=postgres`

`POSTGRES_PASSWORD`

`PGDATA=/var/lib/postgresql/data/pgdata`

Environment variables to pass to the container for WAL-E, all of these must be present or WAL-E is not configured.

`AWS_ACCESS_KEY_ID`

`AWS_SECRET_ACCESS_KEY`

`WALE_S3_PREFIX=\"s3://<bucketname>/<path>\"`

`WALE_RETAIN=7`
