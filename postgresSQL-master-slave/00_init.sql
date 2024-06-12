create user replicator with replication encrypted password 'replicator_password';
select pg_create_physical_replication_slot('replication_slot');
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replicator;