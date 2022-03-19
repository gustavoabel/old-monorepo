/*------------------------------------------------------------------------------------
 GRANTS
 ------------------------------------------------------------------------------------*/

grant all on schema ${pss_schema} to ${db_owner};
grant all on all tables in schema ${pss_schema} to ${db_owner};
grant usage, select on all sequences in schema ${pss_schema} to public;
