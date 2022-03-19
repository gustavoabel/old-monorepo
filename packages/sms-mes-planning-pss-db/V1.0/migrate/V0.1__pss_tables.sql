/*------------------------------------------------------------------------------------
 CREATE TYPES
 ------------------------------------------------------------------------------------*/

create type ${pss_schema}.planning_status as enum ('PLANNING', 'BOOKED', 'SENT TO MES', 'RETURNED BY MES', 'DELETED');
create type ${pss_schema}.execution_status as enum ('NOT STARTED', 'IN PREPARATION', 'IN PROCESS', 'INTERRUPTED', 'FINISHED', 'DELETED');
create type ${pss_schema}.material_attribute_definition_type as enum ('date', 'text', 'number', 'boolean');
create type ${pss_schema}.sequence_chart_type as enum ('LINE', 'BAR', 'COLUMN', 'SCATTER');
create type ${pss_schema}.material_selection_type as enum ('INPUT', 'OUTPUT');
create type ${pss_schema}.production_unit_relationship as enum ('1:1', '1:N');
create type ${pss_schema}.mes_integration_type as enum ('MATERIALS', 'TRANSITIONS');

/*------------------------------------------------------------------------------------
 CREATE TABLES
 ----------------------------------------------------------------------------------*/

create table ${pss_schema}.production_unit_group (
    id                    int primary key generated always as identity,
    has_predecessor       boolean not null,
    has_successor         boolean not null,
    name                  varchar(256) not null
);

create table ${pss_schema}.production_unit_group_ui_layout (
    id                        int primary key generated always as identity,
    layout                    json not null,
    production_unit_group_id  int not null references ${pss_schema}.production_unit_group(id)
);

create table ${pss_schema}.production_unit_type (
    id               int primary key generated always as identity,
    name             varchar(256) not null,
    relationship     ${pss_schema}.production_unit_relationship not null
);

create table ${pss_schema}.production_unit (
    id                        int primary key generated always as identity,
    name                      varchar(256) not null,
    is_sequence_calculated    boolean not null,
    last_unit                 boolean not null,
    production_unit_group_id  int not null references ${pss_schema}.production_unit_group(id),
    production_unit_type_id   int not null references ${pss_schema}.production_unit_type(id),
    material_selection_type   ${pss_schema}.material_selection_type not null
);

create table ${pss_schema}.production_flow (
    id                       int primary key generated always as identity,
    from_production_unit_id  int not null references ${pss_schema}.production_unit(id),
    to_production_unit_id    int not null references ${pss_schema}.production_unit(id)
);

create table ${pss_schema}.material_type (
    id      int primary key generated always as identity,
    name    varchar(256) not null
);

create table ${pss_schema}.production_unit_material_type (
    id                  int primary key generated always as identity,
    is_input            boolean not null,
    is_output           boolean not null,
    production_unit_id  int not null references ${pss_schema}.production_unit(id),
    material_type_id    int not null references ${pss_schema}.material_type(id)
);

create table ${pss_schema}.material_attribute_definition (
    id                        int primary key generated always as identity,
    name                      varchar(256) not null,
    type                      ${pss_schema}.material_attribute_definition_type not null,
    uom                       varchar(16),
    editable                  boolean not null,
    min                       double precision,
    max                       double precision,
    material_type_id          int not null references ${pss_schema}.material_type(id)
);

create table ${pss_schema}.sequence_chart (
    id                                int primary key generated always as identity,
    type                              ${pss_schema}.sequence_chart_type not null,
    default_config                    json not null,
    is_default                        boolean not null,
    production_unit_id                int not null references ${pss_schema}.production_unit(id)
);

create table ${pss_schema}.sequence_chart_attribute (
    id                                int primary key generated always as identity,
    sequence_chart_id                 int not null references ${pss_schema}.sequence_chart(id),
    material_attribute_definition_id  int not null references ${pss_schema}.material_attribute_definition(id)
);

create table ${pss_schema}.group_sequence (
    id                        int primary key generated always as identity,
    name                      varchar(256) not null,
    start_date                timestamp with time zone not null,
    remark                    text,
    planning_status           ${pss_schema}.planning_status not null default 'PLANNING',
    execution_status          ${pss_schema}.execution_status not null default 'NOT STARTED',
    production_unit_group_id  int not null references ${pss_schema}.production_unit_group(id),
    predecessor_sequence_id   int,
    successor_sequence_id     int
);

create table ${pss_schema}.material_filter (
    id                        int primary key generated always as identity,
    name                      varchar(256) not null,
    description               varchar(200),
    expression                json not null,
    is_default                boolean not null,
    production_unit_group_id  int not null references ${pss_schema}.production_unit_group(id)
);

create table ${pss_schema}.material_filter_attribute (
    id                                   int primary key generated always as identity,
    material_filter_id                   int not null references ${pss_schema}.material_filter(id),
    material_attribute_definition_id     int not null references ${pss_schema}.material_attribute_definition(id)
);

create table ${pss_schema}.planning_horizon (
    id                                   int primary key generated always as identity,
    horizon                              int not null,
    name                                 varchar(256) not null,
    description                          text,
    is_default                           boolean not null,
    production_unit_group_id             int not null references ${pss_schema}.production_unit_group(id),
    material_attribute_definition_id     int not null references ${pss_schema}.material_attribute_definition(id)
);

create table ${pss_schema}.optimizer_setup (
    id                             int primary key generated always as identity,
    is_default                     boolean not null,
    -- api
    production_unit_group_id       int not null references ${pss_schema}.production_unit_group(id)
);

create table ${pss_schema}.optimizer_setup_item (
    id                                   int primary key generated always as identity,
    weight                               boolean not null,
    optimizer_setup_id                   int not null references ${pss_schema}.optimizer_setup(id),
    material_attribute_definition_id     int not null references ${pss_schema}.material_attribute_definition(id)
);

create table ${pss_schema}.production_unit_group_kpi (
    id                             int primary key generated always as identity,
    production_unit_group_id       int not null references ${pss_schema}.production_unit_group(id)
);

create table ${pss_schema}.kpi_definition (
    id                             int primary key generated always as identity,
    name                           varchar(256) not null,
    uom                            varchar(16),
    -- implementation
    -- cron_expression
    production_unit_group_kpi_id   int not null references ${pss_schema}.production_unit_group_kpi(id)
);

create table ${pss_schema}.kpi (
    id                             int primary key generated always as identity,
    -- value
    -- date
    kpi_definition_id              int not null references ${pss_schema}.kpi_definition(id)
);

create table ${pss_schema}.sequence_scenario (
    id                                 int primary key generated always as identity,
    name                               varchar(256) not null,
    remark                             text,
    rating                             int not null default 3,
    group_sequence_id                  int not null references ${pss_schema}.group_sequence(id),
    selected                           boolean not null default false,
    deleted                            boolean not null default false,
    material_filter_id                 int references ${pss_schema}.material_filter(id) on delete set null,
    planning_horizon_id                int references ${pss_schema}.planning_horizon(id) on delete set null,
    is_optimized                       boolean default null
);

create table ${pss_schema}.sequence_scenario_version (
    id                                int primary key generated always as identity,
    name                              varchar(256) not null,
    created_date                      timestamp not null default CURRENT_TIMESTAMP,
    remark                            text,
    sequence_scenario_id              int not null references ${pss_schema}.sequence_scenario(id),
    kpi_id                            int references ${pss_schema}.kpi(id) on delete set null,
    unique (name, sequence_scenario_id)
);

create table ${pss_schema}.unit_sequence (
    id                                int primary key generated always as identity,
    sequence_scenario_version_id      int not null references ${pss_schema}.sequence_scenario_version(id),
    production_unit_id                int not null references ${pss_schema}.production_unit(id),
    unique (sequence_scenario_version_id, production_unit_id)
);

create table ${pss_schema}.heat_group (
	id                   int primary key generated always as identity,
	group_number         int not null,
	unit_sequence_id     int references ${pss_schema}.unit_sequence(id) on delete set null,
    heat_steel_grade_int varchar not null
);


create table ${pss_schema}.sequence_item (
    id                        int primary key generated always as identity,
    item_order                int not null,
    -- execution_status
    unit_sequence_id          int not null references ${pss_schema}.unit_sequence(id),
    heat_group_id             int references ${pss_schema}.heat_group(id) on delete set null
);

create table ${pss_schema}.scheduling_rule (
    id                                  int primary key generated always as identity,
    name                                varchar(256) not null,
    remark                              text,
    implementation                      text not null,
    implementation_transpiled           text not null,
    -- cost
    -- coloring
    material_attribute_definition_id    int not null references ${pss_schema}.material_attribute_definition(id),
    production_unit_id                  int not null references ${pss_schema}.production_unit(id)
);

create table ${pss_schema}.scheduling_rule_violation (
    id                            int primary key generated always as identity,
    scheduling_rule_id            int not null references ${pss_schema}.scheduling_rule(id),
    sequence_item_id              int not null references ${pss_schema}.sequence_item(id),
    position_from                 varchar(50) not null,
    position_to                   varchar(50) not null
);

create table ${pss_schema}.scheduling_rule_violation_suppression (
    id                             int primary key generated always as identity,
    -- justification
    responsible                    varchar(50) not null,
    scheduling_rule_violation_id   int not null references ${pss_schema}.scheduling_rule_violation(id)
);

create table ${pss_schema}.material (
    id                            int primary key generated always as identity,
    weight                        double precision not null,
    is_placeholder                boolean not null,
    is_internally_calculated      boolean not null,
    unit_sequence_id              int references ${pss_schema}.unit_sequence(id) on delete set null,
    material_type_id              int not null references ${pss_schema}.material_type(id)
);

create table ${pss_schema}.output_material (
    id                            int primary key generated always as identity,
    material_order                int not null,
    sequence_item_id              int not null references ${pss_schema}.sequence_item(id),
    material_id                   int not null references ${pss_schema}.material(id)
);

create table ${pss_schema}.input_material (
    id                            int primary key generated always as identity,
    material_order                int not null,
    sequence_item_id              int not null references ${pss_schema}.sequence_item(id),
    material_id                   int not null references ${pss_schema}.material(id)
);

create table ${pss_schema}.material_attribute (
    id                                int primary key generated always as identity,
    value                             text,
    min                               double precision,
    max                               double precision,
    material_id                       int not null references ${pss_schema}.material(id),
    material_attribute_definition_id  int not null references ${pss_schema}.material_attribute_definition(id)
);

create table ${pss_schema}.sequence_material_attribute (
    id                          int primary key generated always as identity,
    edited_value                double precision not null,
    responsible                 varchar(50) not null,
    sequence_item_id            int not null references ${pss_schema}.sequence_item(id),
    material_id                 int not null references ${pss_schema}.material(id),
    material_attribute_id       int not null references ${pss_schema}.material_attribute(id)
);

create table ${pss_schema}.production_unit_limit_configuration (
    id                          int primary key generated always as identity,
    min_heat_weight             int not null,
    max_heat_weight             int not null,
    min_sequence_size           int not null,
    max_sequence_size           int not null,
    production_unit_id          int not null references ${pss_schema}.production_unit(id)

);

create table ${pss_schema}.mes_integration (
    id                  int primary key generated always as identity,
    last_integration    timestamp with time zone not null,
    integration_type    ${pss_schema}.mes_integration_type not null
);

create table ${pss_schema}.optimizer_integration (
    id                  int primary key generated always as identity,
    task_running        boolean not null default false
);

create table ${pss_schema}.custom_column_order (
	id                  int primary key generated always as identity,
	table_name          varchar not null,
	user_id             varchar not null,
	column_order        varchar not null
);

create table ${pss_schema}.material_attribute_transition (
    id                                    int primary key generated always as identity,
    material_attribute_definition_id  int not null references ${pss_schema}.material_attribute_definition(id),
    transition_from                       varchar(255),
    transition_to                         varchar(255),
    classification                        varchar(255),
    active                                boolean not null,
    unique (material_attribute_definition_id, transition_from, transition_to)
);
