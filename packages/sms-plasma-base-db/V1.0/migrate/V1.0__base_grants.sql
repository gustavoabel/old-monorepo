/*------------------------------------------------------------------------------------
 GRANTS
 ------------------------------------------------------------------------------------*/

grant all on schema ${base_schema} to ${db_owner};
grant all on all tables in schema ${base_schema} to ${db_owner};
grant usage, select on all sequences in schema ${base_schema} to public;
