#!/bin/bash
set -e

# Configure PostgreSQL for replication
cat >> ${PGDATA}/postgresql.conf <<EOF
wal_level = replica
max_wal_senders = 3
wal_keep_size = 64
EOF

cat >> ${PGDATA}/pg_hba.conf <<EOF
host replication repl_user 0.0.0.0/0 md5
EOF

# Create replication user
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
CREATE USER repl_user REPLICATION LOGIN ENCRYPTED PASSWORD 'repl_user';
EOSQL
