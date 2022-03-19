/*------------------------------------------------------------------------------------
 GRANTS
 ------------------------------------------------------------------------------------*/

grant all on schema ${security_schema} to ${db_owner};
grant all on all tables in schema ${security_schema} to ${db_owner};
grant usage, select on all sequences in schema ${security_schema} to public;
