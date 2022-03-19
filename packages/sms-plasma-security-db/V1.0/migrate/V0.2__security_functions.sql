/*------------------------------------------------------------------------------------
 CREATE FUNCTIONS/PROCEDURES
 ------------------------------------------------------------------------------------*/

-- creates a user session to an application
-- this is needed so the row level security mechanism can evaluate a policy based
-- on the users permissions
--
create or replace function ${security_schema}.session(user_id int, application_code text)
    returns void as $body$
declare
    config text;
    app_id integer;
begin

    execute 'set role postgres;';

    assert user_id is not null, 'user_id should not be null (${security_schema}.session()})';
    assert application_code is not null, 'Application code should not be null (${security_schema}.session()})';

	execute 'select a.id from ${security_schema}.application a where a.code = ''' || application_code || ''';' into app_id;
    assert app_id is not null, 'Invalid application code ' || application_code || ' (${security_schema}.session())';

    execute 'select u.username from ${security_schema}.user u where u.id = ' || user_id || ';' into config;
    assert config is not null, 'Invalid user_id ' || user_id || ' (${security_schema}.session())';

    perform set_config('session.user.name', config, false);

    execute 'select cast(p.permissions as text) from ${security_schema}.narrowed_user_permission p where p.user_id = ' || user_id ||
                ' and p.application_id = ' || app_id || ';' into config;
    perform set_config('session.user.permissions', config, false);

    execute 'select count(distinct u.*) = 1'
            || ' from ${security_schema}.role r, ${security_schema}.user_role ur, ${security_schema}.user u'
            || ' where u.id = ' || user_id
            || ' and (( u.is_admin = true)'
            || '    or ('
            || '        r.application_id = ' || app_id
            || '        and u.id = ur.user_id'
            || '        and r.id = ur.role_id'
            || '        and r.is_admin = true'
            || '    ));' into config;
    perform set_config('session.user.isAdmin', config, false);

    execute 'set role ${db_owner};';
end;
$body$ language plpgsql;


-- helper function to check if the table is already a domain entity (inherits from domain_entity)
--
create or replace function ${security_schema}.is_domain_entity(schema_name text, table_name text)
    returns boolean as $body$
declare
    res boolean;
begin
    select count(*) = 1 into
        res
    from
        pg_catalog.pg_class pc1,
        pg_catalog.pg_class pc2,
        pg_catalog.pg_inherits pi,
        pg_catalog.pg_namespace pn
    where
        pn.nspname = schema_name and
        pc1.relnamespace = pn.oid and
        pc2.relnamespace = pn.oid and
        pc1.oid != pc2.oid and
        pc1.relname = 'domain_entity' and
        pc2.relname = table_name and
        pc1.oid = pi.inhparent and
        pc2.oid = pi.inhrelid;
    return res;
end;
$body$ language plpgsql;


-- Utility function to set policy and enable row level security for domain entities
-- IMPORTANT: currently working ONLY for resource_type = table
-- IMPORTANT: currently working ONLY for single dimensional domains
--
create or replace function ${security_schema}.enable_rls(schema_name text, table_name text)
    returns void as $body$
declare
    table_fqn         text;
    policy_exist      boolean;
    is_domain_entity  boolean;
    cmd               text;
begin

    -- table full qualified name
    table_fqn = schema_name || '.' || table_name;

    -- drop any previously created policy
    cmd =
    	'select count(*) = 1 ' ||
        ' from pg_catalog.pg_policies ' ||
        ' where schemaname = ''' || schema_name || '''' ||
        ' and tablename = ''' || table_name  || '''' ||
        ' and policyname = ''domain_access'';';

    execute cmd into policy_exist;
    if policy_exist then
        execute 
            'alter table ' || table_fqn || ' disable row level security;';
        execute 
            'drop policy domain_access on ' || table_fqn || ';';
    end if;

    -- create rls policy 
    cmd = 
        'create policy domain_access on ' || table_fqn || ' as permissive for all to public using (' ||
        '    current_setting(''session.user.isAdmin'')::boolean or '||
        '    (' ||
        '        select ''' || table_name || ':READ'' in (select skeys(current_setting(''session.user.permissions'')::hstore)) and ' ||
        '        ((current_setting(''session.user.permissions'')::hstore -> ''' || table_name || ':READ'')::ltree[][])[1][1] @> domain[1][1] ' ||
        '    ) ' ||
        ') with check ( ' ||
        '    current_setting(''session.user.isAdmin'')::boolean or ' ||
        '    ( ' ||
        '        select ''' || table_name || ':WRITE'' in (select skeys(current_setting(''session.user.permissions'')::hstore)) and ' ||
        '        ((current_setting(''session.user.permissions'')::hstore -> ''' || table_name || ':WRITE'')::ltree[][])[1][1] @> domain[1][1] ' ||
        '    ) ' ||
        ')';

    execute cmd;

    --  and finally enable rls
    execute 'alter table ' || table_fqn || ' enable row level security;';
end;
$body$ language plpgsql;
