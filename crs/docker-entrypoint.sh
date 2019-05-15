#!/bin/bash

if [ "$1" = "crserver" ]; then
  exec gosu usr1cv8 /opt/1C/v8.3/i386/crserver -port 1542 -d /home/usr1cv8/.1cv8
fi

exec "$@"
