#!/bin/sh
set -e

host="$1"
shift
cmd="$@"

until redis-cli -h "$host" ping; do
  >&2 echo "Redis is unavailable - sleeping"
  sleep 1
done

>&2 echo "Redis is up - executing command"
exec $cmd