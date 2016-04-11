#!/bin/bash

if [ "$AWS_ACCESS_KEY_ID" = "" ]
then
    echo "AWS_ACCESS_KEY_ID does not exist"
else
    if [ "$AWS_SECRET_ACCESS_KEY" = "" ]
    then
        echo "AWS_SECRET_ACCESS_KEY does not exist"
    else
        if [ "$WALE_S3_PREFIX" = "" ]
        then
            echo "WALE_S3_PREFIX does not exist"
        else
            # Assumption: the group is trusted to read secret information
            umask u=rwx,g=rx,o=

            # wal-e specific
            echo "wal_level = archive" >> /var/lib/postgresql/data/postgresql.conf
            echo "archive_mode = on" >> /var/lib/postgresql/data/postgresql.conf
            echo "archive_command = 'envdir /etc/wal-e.d/env /usr/local/bin/wal-e wal-push %p'" >> /var/lib/postgresql/data/postgresql.conf
            echo "archive_timeout = 60" >> /var/lib/postgresql/data/postgresql.conf
        fi
    fi
fi
