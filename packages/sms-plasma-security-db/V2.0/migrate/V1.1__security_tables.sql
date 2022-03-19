/*------------------------------------------------------------------------------------
 CREATE TYPES
 ------------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------------
 CREATE TABLES
 ------------------------------------------------------------------------------------*/

create table ${security_schema}.favorite_type (
    id               int           primary key generated always as identity,
    application_id   int           references ${security_schema}.application (id) not null,
    name             varchar(1023) not null,
    unique (application_id, name)
);

create table ${security_schema}.favorite (
    id               int      primary key generated always as identity,
    user_id          int      references ${security_schema}.user (id) not null,
    favorite_type_id int      references ${security_schema}.favorite_type (id) not null,
    key              int      not null,
    unique (user_id, favorite_type_id, key)
);

create table ${security_schema}.access_log (
    id               int            primary key generated always as identity,
    user_id          int            references ${security_schema}.user (id) not null,
    favorite_type_id int            references ${security_schema}.favorite_type (id) not null,
    key              int            not null,
    access_time      timestamptz     not null default CURRENT_TIMESTAMP
);
