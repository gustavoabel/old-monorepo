/*------------------------------------------------------------------------------------
 CREATE VIEWS
 ------------------------------------------------------------------------------------*/


create or replace view ${base_schema}.foreign_keys as
select
    tc.table_schema, tc.table_name, kcu.column_name,
    ccu.table_schema as foreign_table_schema, ccu.table_name as foreign_table_name,
    ccu.column_name as foreign_column_name
from
    information_schema.table_constraints as tc
    join information_schema.key_column_usage 
        as kcu on tc.constraint_name = kcu.constraint_name
    join information_schema.constraint_column_usage 
        as ccu on ccu.constraint_name = tc.constraint_name
where constraint_type = 'FOREIGN KEY';



create materialized view ${base_schema}.foreign_key_contraints as 
with fks as (
select 
    ccu.table_schema as f_table_schema,
    ccu.table_name as f_table_name,
    ccu.column_name as f_column_name,
    tc.table_schema, 
    tc.table_name, 
    kcu.column_name,
    rc.delete_rule 
from 
    information_schema.table_constraints as tc 
    join information_schema.key_column_usage as kcu
      on tc.constraint_name = kcu.constraint_name
      and tc.table_schema = kcu.table_schema
    join information_schema.constraint_column_usage as ccu
      on ccu.constraint_name = tc.constraint_name
    join information_schema.referential_constraints rc 
      on rc.constraint_name = ccu.constraint_name 
where tc.constraint_type = 'FOREIGN KEY'
	and tc.table_schema not like 'pg_%' 
	and tc.table_schema not like '_timescale%' 
	and tc.table_schema not in ('public', 'information_schema', 'timescaledb_information')
)
select fks.*, c.is_nullable from fks
join information_schema.columns c 
  on c.table_schema = fks.table_schema 
  and c.table_name = fks.table_name
  and c.column_name = fks.column_name
order by 1, 2, 3, 4, 5;

create index foreign_key_contraints_idx on ${base_schema}.foreign_key_contraints (f_table_schema, f_table_name, table_schema);
