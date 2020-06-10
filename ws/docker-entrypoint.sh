#!/bin/bash

if [ "$1" != "" ]; then
  exec "$@"
fi

# start apache2
source /etc/apache2/envvars
exec /usr/sbin/apache2 -DFOREGROUND
