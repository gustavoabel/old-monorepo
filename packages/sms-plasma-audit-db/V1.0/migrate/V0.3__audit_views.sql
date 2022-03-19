/*------------------------------------------------------------------------------------
 CREATE VIEWS
 ------------------------------------------------------------------------------------*/

create or replace view ${audit_schema}.tableslist as 
   select distinct triggers.trigger_schema as schema, triggers.event_object_table as auditedtable
   from information_schema.triggers
   where triggers.trigger_name::text in ('audit_trigger_row'::text, 'audit_trigger_stm'::text)  
order by schema, auditedtable;
