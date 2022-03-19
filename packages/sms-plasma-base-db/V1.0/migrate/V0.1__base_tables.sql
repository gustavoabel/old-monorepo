/*------------------------------------------------------------------------------------
 CREATE TYPES
 ------------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------------
 CREATE TABLES
 ------------------------------------------------------------------------------------*/


create table ${base_schema}.table_config (
    schema_name text not null,
    table_name text not null,
    name_query text not null,
    unique(schema_name, table_name)
);


create table ${base_schema}.error_log (
    dts timestamptz not null default current_timestamp,
    error_text  text,
    function_name text,
    args text
);