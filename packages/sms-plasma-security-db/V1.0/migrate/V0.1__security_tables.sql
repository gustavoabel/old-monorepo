/*------------------------------------------------------------------------------------
 CREATE TYPES
 ------------------------------------------------------------------------------------*/

create type ${security_schema}.application_status as enum ('ACTIVE', 'INACTIVE');
create type ${security_schema}.role_status as enum ('ACTIVE', 'INACTIVE');
create type ${security_schema}.rt_type as enum ('TABLE', 'UI');
create type ${security_schema}.permission_action as enum ('READ', 'WRITE');
create type ${security_schema}.ip_status as enum ('CREATED', 'ACTIVE', 'INACTIVE');
create type ${security_schema}.user_status as enum ('PENDING', 'ACTIVE', 'INACTIVE', 'LOCKED');
create type ${security_schema}.user_type as enum ('PERSON', 'THING', 'GROUP');
create type ${security_schema}.pwd_policy_status as enum ('ACTIVE', 'INACTIVE');
create type ${security_schema}.app_environment_type as enum ('DEMO','DEVELOPMENT','PRODUCTION','QA');

/*------------------------------------------------------------------------------------
 CREATE TABLES
 ------------------------------------------------------------------------------------*/

create table if not exists ${security_schema}.domain_entity(
    domain ltree[][] not null default array[array[]::ltree[]]::ltree[]
);

create table ${security_schema}.application (
    id               int            primary key generated always as identity,
    display_order    real                unique not null,
    code             varchar(16)         not null,
    name             varchar(255)        not null,
    url              varchar(255)        not null,
    description      text,
    status           ${security_schema}.application_status    default 'ACTIVE',
    icon             text        not null   default 'data:image/svg+xml;base64,PCEtLSBHZW5lcmF0b3I6IEFkb2JlIElsbHVzdHJhdG9yIDIzLjAuNiwgU1ZHIEV4cG9ydCBQbHVnLUluICAtLT4NCjxzdmcgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjQ5NS4ycHgiDQoJIGhlaWdodD0iNDk1LjJweCIgdmlld0JveD0iMCAwIDQ5NS4yIDQ5NS4yIiBzdHlsZT0iZW5hYmxlLWJhY2tncm91bmQ6bmV3IDAgMCA0OTUuMiA0OTUuMjsiIHhtbDpzcGFjZT0icHJlc2VydmUiPg0KPHN0eWxlIHR5cGU9InRleHQvY3NzIj4NCgkuc3Qwe2ZpbGw6I0UxMDgxNDt9DQoJLnN0MXtmaWxsOiMwNzc1QkM7fQ0KCS5zdDJ7ZmlsbDojRkZGRkZGO30NCjwvc3R5bGU+DQo8ZGVmcz4NCjwvZGVmcz4NCjxwb2x5Z29uIGNsYXNzPSJzdDAiIHBvaW50cz0iMjQ2LjksMCAyNDYuOSwxNjUuMSAzMzAuMSwxNjUuMSAzMzAuMSwyNDYuOSA0OTUuMiwyNDYuOSA0OTUuMiwwICIvPg0KPHBvbHlnb24gY2xhc3M9InN0MSIgcG9pbnRzPSIzMzAuMSw0OTUuMiAzMzAuMSwzMzAuMSAxNjUuMSwzMzAuMSAxNjUuMSwxNjUuMSAwLDE2NS4xIDAsNDk1LjIgIi8+DQo8cmVjdCB4PSIyMDYiIHk9IjIwNiIgY2xhc3M9InN0MiIgd2lkdGg9IjgzLjIiIGhlaWdodD0iODMuMiIvPg0KPC9zdmc+DQo=',
    parameters       json,
    parameters_value json,
    app_environment  ${security_schema}.app_environment_type     not null,
    assigned_by_default   boolean    not null   default false,
    deleted_at       timestamp,
    unique (code, deleted_at)
) inherits (${security_schema}.domain_entity);

create table ${security_schema}.domain_type (
    id             int      primary key generated always as identity,
    application_id int      references ${security_schema}.application (id) not null,
    code           varchar(16)   unique not null,
    name           varchar(255)  not null,
    unique (application_id, code),
    unique (application_id, name)
);

create table ${security_schema}.domain (
    id             int           primary key generated always as identity,
    domain_type_id int      references ${security_schema}.domain_type (id) on delete cascade not null,
    path           ltree         not null,
    name           varchar(255)  not null,
    unique (domain_type_id, path),
    unique (domain_type_id, name)
);

create table ${security_schema}.resource_type (
    id             int          primary key generated always as identity,
    application_id int          references ${security_schema}.application (id) not null,
    name           varchar(255)      not null,
    is_primary     boolean           not null,
    type           ${security_schema}.rt_type,
    unique (application_id, name)
);

create table ${security_schema}.resource_domain_type (
    resource_type_id int references ${security_schema}.resource_type (id) on delete cascade not null,
    domain_type_id   int references ${security_schema}.domain_type (id) on delete cascade not null,
    unique (resource_type_id, domain_type_id)
);

create table ${security_schema}.permission (
    id               int                   primary key generated always as identity,
    resource_type_id int                   references ${security_schema}.resource_type (id) on delete cascade not null,
    action           ${security_schema}.permission_action    not null,
    unique (resource_type_id, action)
);

create table ${security_schema}.permission_inheritance (
    parent_permission_id int references ${security_schema}.permission (id) on delete cascade not null,
    child_permission_id  int references ${security_schema}.permission (id) on delete cascade not null,
    unique (parent_permission_id, child_permission_id)
);

create table ${security_schema}.role (
    id             int              primary key generated always as identity,
    application_id int              references ${security_schema}.application (id) not null,
    name           varchar(255)          not null,
    description    text,
    is_admin       boolean               not null default false,
    status         ${security_schema}.role_status    default 'ACTIVE',
    deleted_at     timestamp,
    assigned_by_default   boolean    not null   default false,
    unique (application_id, name, deleted_at)
) inherits (${security_schema}.domain_entity);

create table ${security_schema}.role_permission (
    role_id       int references ${security_schema}.role (id) not null,
    permission_id int references ${security_schema}.permission (id) on delete cascade not null,
    unique (role_id, permission_id)
);

create table ${security_schema}.identity_provider_type (
    id        int     primary key generated always as identity,
    name      varchar(255) unique not null,
    sign_in_source      text,
    has_sign_up         boolean   not null default false,
    sign_up_source      text,
    has_refresh         boolean   not null default false,
    refresh_source      text,
    has_change_password boolean   not null default false,
    change_password_source  text,
    has_delete_user     boolean   not null default false,
    delete_user_source  text,
    param_def json
);

create table ${security_schema}.identity_provider (
    id                        int           primary key generated always as identity,
    identity_provider_type_id int           references ${security_schema}.identity_provider_type (id) on delete cascade not null,
    name                      varchar(255)       unique not null,
    status                    ${security_schema}.ip_status    default 'CREATED',
    description               text,
    param_val                 json,
    domain_whitelist          text,
    is_default                boolean
);

create table ${security_schema}.user (
    id                   int                  primary key generated always as identity,
    identity_provider_id int             references ${security_schema}.identity_provider (id) not null,
    type                 ${security_schema}.user_type      default 'PERSON',
    status               ${security_schema}.user_status    default 'ACTIVE',
    username             varchar(255)         not null,
    password             varchar(255),
    first_name           varchar(255),
    last_name            varchar(255),
    email                varchar(255),
    timezone             varchar(255),
    is_admin             boolean              default false,
    last_pwds            varchar(255)[]       default '{}',
    pwd_changed_at       timestamp,
    deleted_at           timestamp,
    unique (username, deleted_at)
);

create table ${security_schema}.user_role (
    user_id int      references ${security_schema}.user (id) not null,
    role_id int references ${security_schema}.role (id) not null,
    unique (user_id, role_id)
);

create table ${security_schema}.user_domain (
    id             int primary key generated always as identity,
    user_id        int references ${security_schema}.user (id) not null,
    permission_id  int references ${security_schema}.permission (id) on delete cascade,
    application_id int references ${security_schema}.application (id),
    constraint default_domain check ((permission_id is null and application_id is not null)
        or (permission_id is not null and application_id is null))
);

create table ${security_schema}.domain_item (
    user_domain_id int references ${security_schema}.user_domain (id) on delete cascade not null,
    domain_id      int references ${security_schema}.domain (id) on delete cascade not null,
    group_id       int not null,
    unique (user_domain_id, domain_id, group_id)
);

create table ${security_schema}.contact_info (
    user_id int              references ${security_schema}.user (id) not null,
    type    varchar(255)     not null,
    value   varchar(255)     not null,
    unique (user_id, type, value)
);

create table ${security_schema}.pwd_policy (
    id             int                              primary key generated always as identity,
    name           varchar(255)                     unique not null,
    status         ${security_schema}.pwd_policy_status not null default 'INACTIVE',
    param_def      json,
    source         text                             not null
);

create table ${security_schema}.refresh_token (
    id                  int              primary key generated always as identity,
    user_id             int,
    token               text              not null,
    expires             timestamp          not null,
    created_at          timestamp          not null    default now(),
    created_by_ip       varchar(255)

);
