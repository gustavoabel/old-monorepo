/*------------------------------------------------------------------------------------
 AUDIT TRAIL
 ------------------------------------------------------------------------------------*/

select ${audit_schema}.audit_table('${security_schema}.application');
select ${audit_schema}.audit_table('${security_schema}.domain_type');
select ${audit_schema}.audit_table('${security_schema}.resource_type');
select ${audit_schema}.audit_table('${security_schema}.domain');
select ${audit_schema}.audit_table('${security_schema}.resource_domain_type');
select ${audit_schema}.audit_table('${security_schema}.permission_inheritance');
select ${audit_schema}.audit_table('${security_schema}.role');
select ${audit_schema}.audit_table('${security_schema}.role_permission');
select ${audit_schema}.audit_table('${security_schema}.identity_provider_type');
select ${audit_schema}.audit_table('${security_schema}.user');
select ${audit_schema}.audit_table('${security_schema}.identity_provider');
select ${audit_schema}.audit_table('${security_schema}.user_role');
select ${audit_schema}.audit_table('${security_schema}.user_domain');
select ${audit_schema}.audit_table('${security_schema}.domain_item');
select ${audit_schema}.audit_table('${security_schema}.contact_info');
select ${audit_schema}.audit_table('${security_schema}.pwd_policy');
select ${audit_schema}.audit_table('${security_schema}.permission');

-- prepare better names
insert into ${base_schema}.table_config(schema_name, table_name, name_query) values(
    '${security_schema}',
    'permission',
    '
    select p.action || '':'' || rt.name 
    from ${security_schema}.permission p 
    join ${security_schema}.resource_type rt on p.resource_type_id = rt.id 
    where p.id = %s
    '
);

insert into ${base_schema}.table_config(schema_name, table_name, name_query) values(
    '${security_schema}',
    'user',
    'select username from ${security_schema}.user u where u.id = %s'
);

/*------------------------------------------------------------------------------------
 SET ORDERED TABLES (ITEM DISPLAY ORDER)
 ------------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------------
 ENABLE ROW LEVEL SECURITY
 ------------------------------------------------------------------------------------*/

-- select ${security_schema}.enable_rls('${security_schema}', 'application');
-- select ${security_schema}.enable_rls('${security_schema}', 'role');
