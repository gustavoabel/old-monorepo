//*------------------------------------------------------------------------------------
 CREATE DATABASE AND USERS
 ------------------------------------------------------------------------------------*/

create user pss;
alter user pss with encrypted password 'Aregano0';

-- drop database
\connect postgres;
 select pid, pg_terminate_backend(pid) from pg_stat_activity where datname = 'pss001' and pid <> pg_backend_pid();
drop database pss001;

-- create database
create database pss001 owner postgres;
\connect pss001;

-- create extensions
create extension if not exists hstore;
create extension if not exists ltree;
create extension if not exists tablefunc;

-- drop flyway schema
drop schema if exists flyway cascade;
create schema if not exists flyway authorization pss;

drop schema if exists mb cascade;
create schema if not exists mb authorization pss;
