#!/bin/bash
set -e

# if diffirent instace change "master" to ip
# Wait for master to be available
until pg_isready -h master -p 5432 -U postgres; do
  sleep 1
done

# Stop PostgreSQL server
pg_ctl -D "$PGDATA" -m fast -w stop

# Clone the master data
# if diffirent instace change "master" to ip
PGPASSWORD=postgres pg_basebackup -h master -D "$PGDATA" -U repl_user -v -P --wal-method=stream

# Configure PostgreSQL for replication
cat >> ${PGDATA}/postgresql.conf <<EOF
hot_standby = on
EOF

# if diffirent instace change "master" to ip
cat > ${PGDATA}/recovery.conf <<EOF
standby_mode = 'on'
primary_conninfo = 'host=master port=5432 user=repl_user password=repl_user'
trigger_file = '/tmp/postgresql.trigger'
EOF

# Start PostgreSQL server
pg_ctl -D "$PGDATA" -o "-c config_file=${PGDATA}/postgresql.conf" -w start
