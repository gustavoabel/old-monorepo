/*------------------------------------------------------------------------------------
 LOAD APPLICATION DATA
 ------------------------------------------------------------------------------------*/
insert into ${security_schema}.resource_type(application_id, name, is_primary, type)
    select
        application.id, tables.name, false, 'TABLE'
    from
        (
            select table_name as name
            from information_schema.tables
            where table_schema = '${audit_schema}' and table_type = 'BASE TABLE'
        ) as tables,
        (
            select id from ${security_schema}.application where code = '${app_code}'
        ) as application
on conflict (application_id, name) do nothing;

update ${security_schema}.resource_type set is_primary = true where name = 'log';

insert into ${security_schema}.permission(resource_type_id, action)
    select p.id, 'READ' from (select id from ${security_schema}.resource_type order by id) as p
on conflict (resource_type_id, action) do nothing;

insert into ${security_schema}.permission(resource_type_id, action)
    select p.id, 'WRITE' from (select id from ${security_schema}.resource_type order by id) as p
on conflict (resource_type_id, action) do nothing;

 --remove flexmonster key parameter
with application_parameters as (
	select a.parameters::jsonb as value
    from ${security_schema}.application a where code = '${app_code}'
)
update ${security_schema}.application
  set parameters = (select value - (select (items.ordinality - 1)::integer
                                      from application_parameters, jsonb_array_elements(value) with ordinality as items
                                    where items.value->'props'->'name' = '"flexmonsterLicense"')
                      from application_parameters)
where code = '${app_code}';

