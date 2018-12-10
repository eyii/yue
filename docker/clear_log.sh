#!/usr/bin/env bash
logs=$(find /var/lib/docker/containers/ -name *-json.log)
for log in $logs;do cat /dev/null > $log ;done



