#!/bin/bash
set -e

# Set up wal-e
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
          mkdir -p /etc/wal-e.d/env

          echo "$AWS_SECRET_ACCESS_KEY" > /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY
          echo "$AWS_ACCESS_KEY_ID" > /etc/wal-e.d/env/AWS_ACCESS_KEY_ID
          echo "$WALE_S3_PREFIX" > /etc/wal-e.d/env/WALE_S3_PREFIX
          chown -R postgres /etc/wal-e.d
          su - postgres -c "crontab -l | { cat; echo \"0 3 * * * /usr/bin/envdir /etc/wal-e.d/env /usr/local/bin/wal-e backup-push $PGDATA\"; } | crontab -"
          su - postgres -c "crontab -l | { cat; echo \"0 4 * * * /usr/bin/envdir /etc/wal-e.d/env /usr/local/bin/wal-e delete --confirm retain ${WALE_RETAIN:-7}\"; } | crontab -"
        fi
    fi
fi
# End

./docker-entrypoint.sh $@
