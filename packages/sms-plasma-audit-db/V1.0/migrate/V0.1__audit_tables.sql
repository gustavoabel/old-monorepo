--
--    https://wiki.postgresql.org/wiki/Audit_trigger_91plus    
--

/*------------------------------------------------------------------------------------
 CREATE TYPES
 ------------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------------
 CREATE TABLES
 ------------------------------------------------------------------------------------*/

create table ${audit_schema}.log (
    id bigserial primary key,
    schema_name text not null,
    table_name text not null,
    relid oid not null,
    session_user_name text,
    action_tstamp_tx timestamp with time zone not null,
    action_tstamp_stm timestamp with time zone not null,
    action_tstamp_clk timestamp with time zone not null,
    transaction_id bigint,
    application_name text,
    client_addr inet,
    client_port integer,
    client_query text,
    action text not null check (action in ('i','d','u', 't','I','D','U', 'T')),
    row_data hstore,
    changed_fields hstore,
    statement_only boolean not null
);

create index log_schema_name_idx on ${audit_schema}.log(schema_name);
create index log_table_name_idx on ${audit_schema}.log(table_name);
create index log_action_tstamp_tx_idx on ${audit_schema}.log(action_tstamp_tx);
create index log_action_idx on ${audit_schema}.log(action);

