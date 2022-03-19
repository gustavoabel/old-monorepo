/*------------------------------------------------------------------------------------
 CREATE FUNCTIONS/PROCEDURES
 ------------------------------------------------------------------------------------*/

create or replace function ${audit_schema}.if_modified_func()
returns trigger
as $body$
declare
    audit_row ${audit_schema}.log;
    include_values boolean;
    log_diffs boolean;
    h_old hstore;
    h_new hstore;
    excluded_cols text[] = array[]::text[];
begin
    if TG_WHEN <> 'AFTER' then
        raise exception '${audit_schema}.if_modified_func() may only run as an after trigger';
    end if;

    audit_row = row(
        nextval('${audit_schema}.log_id_seq'),                  -- id
        TG_TABLE_SCHEMA::text,                        -- schema_name
        TG_TABLE_NAME::text,                          -- table_name
        TG_RELID,                                     -- relation oid for much quicker searches
        coalesce(current_setting('session.user.name', 't'), session_user::text),                           -- session_user_name
        current_timestamp,                            -- action_tstamp_tx
        statement_timestamp(),                        -- action_tstamp_stm
        clock_timestamp(),                            -- action_tstamp_clk
        txid_current(),                               -- transaction id
        coalesce(nullif(current_setting('application_name'), '') , '${app_name}'),          -- client application
        inet_client_addr(),                           -- client_addr
        inet_client_port(),                           -- client_port
        current_query(),                              -- top-level query or queries (if multistatement) from client
        substring(tg_op,1,1),                         -- action
        null, null,                                   -- row_data, changed_fields
        'f'                                           -- statement_only
    );

    if not TG_ARGV[0]::boolean is distinct from 'f'::boolean then
        audit_row.client_query = null;
    end if;

    if TG_ARGV[1] is not null then
        excluded_cols = TG_ARGV[1]::text[];
    end if;

    if (TG_OP = 'UPDATE' and TG_LEVEL = 'ROW') then
        audit_row.row_data = hstore(OLD.*) - excluded_cols;
        audit_row.changed_fields =  (hstore(NEW.*) - audit_row.row_data) - excluded_cols;
        if audit_row.changed_fields = hstore('') then
            -- All changed fields are ignored. Skip this update.
            return null;
        end if;

    elsif (TG_OP = 'DELETE' and TG_LEVEL = 'ROW') then
        audit_row.row_data = hstore(OLD.*) - excluded_cols;

    elsif (TG_OP = 'INSERT' and TG_LEVEL = 'ROW') then
        audit_row.row_data = hstore(NEW.*) - excluded_cols;

    elsif (TG_LEVEL = 'STATEMENT' and TG_OP IN ('INSERT','UPDATE','DELETE','TRUNCATE')) then
        audit_row.statement_only = 't';

    else
        raise exception '[${audit_schema}.if_modified_func] - Trigger func added as trigger for unhandled case: %, %', TG_OP, TG_LEVEL;
        return null;
    end if;

    -- process foreign keys
    select ${base_schema}.process_fks(audit_row.schema_name, audit_row.table_name, audit_row.row_data) into audit_row.row_data;
    select ${base_schema}.process_fks(audit_row.schema_name, audit_row.table_name, audit_row.changed_fields) into audit_row.changed_fields;

    -- insert log record
    insert into ${audit_schema}.log values (audit_row.*);
    return null;
end;
$body$
language plpgsql
security definer
set search_path = pg_catalog, public;


create or replace function ${audit_schema}.audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean, ignored_cols text[])
returns void
as $body$
declare
  stm_targets text = 'insert or update or delete or truncate';
  _q_txt text;
  _ignored_cols_snip text = '';
begin
    execute 'drop trigger if exists audit_trigger_row on ' || target_table;
    execute 'drop trigger if exists audit_trigger_stm on ' || target_table;

    if audit_rows then
        if array_length(ignored_cols,1) > 0 then
            _ignored_cols_snip = ', ' || quote_literal(ignored_cols);
        end if;
        _q_txt = 'create trigger audit_trigger_row after insert or update or delete on ' ||
                 target_table ||
                 ' for each row execute procedure ${audit_schema}.if_modified_func(' ||
                 quote_literal(audit_query_text) || _ignored_cols_snip || ');';
        --raise notice '%',_q_txt;
        execute _q_txt;
        stm_targets = 'truncate';
    else
    end if;

    _q_txt = 'create trigger audit_trigger_stm after ' || stm_targets || ' on ' ||
             target_table ||
             ' for each statement execute procedure ${audit_schema}.if_modified_func('||
             quote_literal(audit_query_text) || ');';
    --raise notice '%',_q_txt;
    execute _q_txt;

end;
$body$ language plpgsql;

-- Pg doesn't allow variadic calls with 0 params, so provide a wrapper

create or replace function ${audit_schema}.audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean)
returns void
as $body$
    select ${audit_schema}.audit_table($1, $2, $3, array[]::text[]);
$body$ language 'sql';


-- and provide a convenience call wrapper for the simplest case
-- of row-level logging with no excluded cols and query logging enabled.
--
create or replace function ${audit_schema}.audit_table(target_table regclass)
returns void
as $body$
    select ${audit_schema}.audit_table($1, boolean 't', boolean 't');
$body$ language 'sql';



create or replace function ${audit_schema}.creation_record(sn text, tn text, id_field text, id_value text)
returns table(created_by varchar(1023), created_at timestamp with time zone)
language sql
as
$$
	select
		l.session_user_name created_by,
		l.action_tstamp_tx created_at
	from
		${audit_schema}.log l
	where
		l.schema_name = sn
		and l.table_name = tn
		and l.action = 'I'
		and l.row_data -> id_field = id_value;
$$;

create or replace function ${audit_schema}.last_update_record(sn text, tn text, id_field text, id_value text)
returns table(updated_by varchar(1023), updated_at timestamp with time zone)
language sql
as
$$
	select
		l.session_user_name updated_by,
		l.action_tstamp_tx updated_at
	from
		${audit_schema}.log l
	where
		l.schema_name = sn
		and l.table_name = tn
		and l.action = 'U'
		and l.row_data -> id_field = id_value
    order by l.action_tstamp_tx desc
    limit 1;
$$;

