/*------------------------------------------------------------------------------------
 AUDIT TRAIL
 ------------------------------------------------------------------------------------*/

select ${audit_schema}.audit_table('${pss_schema}.group_sequence');
select ${audit_schema}.audit_table('${pss_schema}.sequence_scenario');
select ${audit_schema}.audit_table('${pss_schema}.sequence_scenario_version');
select ${audit_schema}.audit_table('${pss_schema}.unit_sequence');
select ${audit_schema}.audit_table('${pss_schema}.planning_horizon');
select ${audit_schema}.audit_table('${pss_schema}.material_filter');
select ${audit_schema}.audit_table('${pss_schema}.material_filter_attribute');
select ${audit_schema}.audit_table('${pss_schema}.scheduling_rule');
select ${audit_schema}.audit_table('${pss_schema}.scheduling_rule_violation');
select ${audit_schema}.audit_table('${pss_schema}.scheduling_rule_violation_suppression');
select ${audit_schema}.audit_table('${pss_schema}.optimizer_setup');
select ${audit_schema}.audit_table('${pss_schema}.optimizer_setup_item');
select ${audit_schema}.audit_table('${pss_schema}.production_unit_group_kpi');
select ${audit_schema}.audit_table('${pss_schema}.kpi_definition');


-- prepare better names
-- insert into ${base_schema}.table_config(schema_name, table_name, name_query) values(
--     '${pss_schema}',
--     'budget',
--     'select c.name || '':'' || b.version
--     from ${pss_schema}.budget b
--     join ${pss_schema}.contract c on b.contract_id = c.id
--     where b.id = %s'
-- );

-- insert into ${base_schema}.table_config(schema_name, table_name, name_query) values(
--     '${pss_schema}',
--     'team_member',
--     'select username from ${pss_schema}.team_member m where m.id = %s'
-- );

/*------------------------------------------------------------------------------------
 SET ORDERED TABLES (ITEM DISPLAY ORDER)
 ------------------------------------------------------------------------------------*/

-- select ${base_schema}.ordered_table('${pss_schema}', 'cost_element_group', 'ce_table_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'cost_element', 'ce_group_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'cost_center_group', 'cc_table_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'cost_center', 'cc_group_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'kpi', 'kpi_table_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'team', 'team_table_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'team_member', 'team_id');
-- select ${base_schema}.ordered_table('${pss_schema}', 'level3_budget_item', 'budget_item_id');


/*------------------------------------------------------------------------------------
 ENABLE ROW LEVEL SECURITY
 ------------------------------------------------------------------------------------*/
