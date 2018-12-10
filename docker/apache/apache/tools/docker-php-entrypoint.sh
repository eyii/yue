#!/bin/sh
echo "$PATH"
/usr/sbin/cron -n
set -e
if [ "${1#-}" != "$1" ]; then
	set -- apache2-foreground "$@"
fi

exec "$@"
