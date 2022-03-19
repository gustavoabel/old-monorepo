/*------------------------------------------------------------------------------------
 LOAD APPLICATION DATA
 ------------------------------------------------------------------------------------*/


 /*------------------------------------------------------------------------------------
 Production Unit Group
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.production_unit_group(name, has_predecessor, has_successor)
	VALUES ('CSP', false, false);

/*------------------------------------------------------------------------------------
 Production Unit Group UI Layout
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.production_unit_group_ui_layout (
    layout, production_unit_group_id)
	VALUES
	('{"format": "columns", "columns": [{"rows": [{"unit": "CSP 1"},{"unit": "CSP 2"}]},{"rows": [{"unit": "HSM"}]}]}', 1);

 /*------------------------------------------------------------------------------------
 Production Unit Type
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.production_unit_type(name, relationship)
	VALUES ('Caster', '1:N');

INSERT INTO ${pss_schema}.production_unit_type(name, relationship)
	VALUES ('HSM', '1:1');


 /*------------------------------------------------------------------------------------
 Production Unit
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.production_unit(name, is_sequence_calculated, last_unit, production_unit_group_id, material_selection_type, production_unit_type_id)
	VALUES ('CCM1', false, false, 1, 'OUTPUT', 1);

INSERT INTO ${pss_schema}.production_unit(name, is_sequence_calculated, last_unit, production_unit_group_id, material_selection_type, production_unit_type_id)
	VALUES ('CCM2', false, false, 1, 'OUTPUT', 1);

INSERT INTO ${pss_schema}.production_unit(name, is_sequence_calculated, last_unit, production_unit_group_id, material_selection_type, production_unit_type_id)
	VALUES ('HSM', false, true, 1, 'OUTPUT', 2);


 /*------------------------------------------------------------------------------------
 Production Flow
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.production_flow(  --From Caster 1 To HRM
	from_production_unit_id, to_production_unit_id)
	VALUES (1, 3);

INSERT INTO ${pss_schema}.production_flow( --From Caster 2 To HRM
	from_production_unit_id, to_production_unit_id)
	VALUES (2, 3);


 /*------------------------------------------------------------------------------------
 Material Type
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.material_type(
	name)
	VALUES ('Heat');

INSERT INTO ${pss_schema}.material_type(
	name)
	VALUES ('Slab');

INSERT INTO ${pss_schema}.material_type(
	name)
	VALUES ('Coil');


 /*------------------------------------------------------------------------------------
 Production Unit Material Type
 ------------------------------------------------------------------------------------*/
INSERT INTO ${pss_schema}.production_unit_material_type( --Heat input of Caster 1
	is_input, is_output, production_unit_id, material_type_id)
	VALUES (true, false, 1, 1);

INSERT INTO ${pss_schema}.production_unit_material_type( --Slab output of Caster 1
	is_input, is_output, production_unit_id, material_type_id)
	VALUES (false, true, 1, 2);

INSERT INTO ${pss_schema}.production_unit_material_type( --Heat input of Caster 2
	is_input, is_output, production_unit_id, material_type_id)
	VALUES (true, false, 2, 1);

INSERT INTO ${pss_schema}.production_unit_material_type( --Slab output of Caster 2
	is_input, is_output, production_unit_id, material_type_id)
	VALUES (false, true, 2, 2);

INSERT INTO ${pss_schema}.production_unit_material_type( --Slab input of HRM
	is_input, is_output, production_unit_id, material_type_id)
	VALUES (true, false, 3, 2);

INSERT INTO ${pss_schema}.production_unit_material_type( --Coil output of HRM
	is_input, is_output, production_unit_id, material_type_id)
	VALUES (false, true, 3, 3);


 /*------------------------------------------------------------------------------------
 Material Attribute Definition
 ------------------------------------------------------------------------------------*/

/*------Heat Attributes----*/

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('HEAT_WEIGHT','number','kg',FALSE,NULL,NULL,1);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('DURATION','number','Min',FALSE,NULL,NULL,1);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('STEEL_GRADE_INT','text','text',FALSE,NULL,NULL,1);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('REMARK','text','text',FALSE,NULL,NULL,1);


/*------Slab Attributes----*/

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_NAME','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_ORDER_ID','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_ORDER_POS','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PRODUCTION_ORDER_ID','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PRODUCTION_STEP_ID','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PROMISED_DATE_LATEST','date','date',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PS_PIECE_ID','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_WIDTH_AIM','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_WIDTH_MAX','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_WIDTH_MIN','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_THICKNESS_AIM','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_THICKNESS_MAX','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_THICKNESS_MIN','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_WEIGHT_AIM','number','kg',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_WEIGHT_MAX','number','kg',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_WEIGHT_MIN','number','kg',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_LENGTH_AIM','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_LENGTH_MAX','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SLAB_LENGTH_MIN','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('STEEL_GRADE_INT','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('STEEL_DESIGN_CD','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_A','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_B','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_C','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_D','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_E','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_F','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_G','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_H','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_I','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_J','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_K','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_L','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_M','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_N','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_O','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('WIDTH_ALT_P','number','mm',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('FLAG_CUMULATIVE_ORDER','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PRODUCT_TYPE_CD','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('NO_FIRST_SLABS_IND','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('LOW_CU','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('LOW_DRAFT','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('NO_DRAFT','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_1','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_2','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_3','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_4','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SPEC_INSTRUCT_PRODUCTION','text','text',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PERFORMANCE','number','kg/seconds',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PERFORMANCE_DUR','number','seconds',FALSE,NULL,NULL,2);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('REMARK','text','text',TRUE,NULL,NULL,2);


/*------Coil Attributes----*/

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_NAME','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_ORDER_ID','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_ORDER_POS','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('CUSTOMER_ORDER_VERSION','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PRODUCTION_ORDER_ID','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PRODUCTION_STEP_ID','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PROMISED_DATE_LATEST','date','date',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PS_PIECE_ID','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_WIDTH_AIM','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_WIDTH_MAX','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_WIDTH_MIN','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_THICKNESS_AIM','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_THICKNESS_MAX','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_THICKNESS_MIN','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_WEIGHT_AIM','number','kg',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_WEIGHT_MAX','number','kg',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_WEIGHT_MIN','number','kg',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_LENGTH_AIM','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_LENGTH_MAX','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('COIL_LENGTH_MIN','number','mm',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('STEEL_GRADE_INT','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('STEEL_DESIGN_CD','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_1','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_2','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_3','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ALT_GRADE_4','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('SPEC_INSTRUCT_PRODUCTION','text','text',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('PERFORMANCE','number','kg/seconds',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('DURATION','number','seconds',FALSE,NULL,NULL,3);

INSERT INTO ${pss_schema}.material_attribute_definition(
	name, type, uom, editable, min, max, material_type_id)
	VALUES ('ROLL_WEAR_ADJUSTMENT','number','mm',TRUE,NULL,NULL,3);

/*------------------------------------------------------------------------------------
Production Unit Limit Configuration
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.production_unit_limit_configuration (
  min_heat_weight, max_heat_weight, min_sequence_size, max_sequence_size, production_unit_id)
    VALUES (0, 0, 0, 0, 2);

INSERT INTO ${pss_schema}.production_unit_limit_configuration (
  min_heat_weight, max_heat_weight, min_sequence_size, max_sequence_size, production_unit_id)
    VALUES (0, 0, 0, 0, 1);
