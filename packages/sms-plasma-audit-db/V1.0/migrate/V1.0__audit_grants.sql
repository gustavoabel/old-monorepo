/*------------------------------------------------------------------------------------
 GRANTS
 ------------------------------------------------------------------------------------*/

grant all on schema ${audit_schema} to ${db_owner};
grant all on all tables in schema ${audit_schema} to ${db_owner};
grant usage, select on all sequences in schema ${audit_schema} to public;
