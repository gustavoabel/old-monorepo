/*------------------------------------------------------------------------------------
 LOAD SAMPLE DATA
 ------------------------------------------------------------------------------------*/

 /*------------------------------------------------------------------------------------
 Planning Horizon
 ------------------------------------------------------------------------------------*/

 INSERT INTO ${pss_schema}.planning_horizon(
	horizon, name, description, is_default, production_unit_group_id, material_attribute_definition_id)
	VALUES (7, 'Planning Horizon 1', 'Planning Horizon 1 Description', true, 1, 10), (7, 'Planning Horizon 2', 'Planning Horizon 2 Description', true, 1, 10);

 /*------------------------------------------------------------------------------------
 Scheduling Rule
 ------------------------------------------------------------------------------------*/

 INSERT INTO ${pss_schema}.scheduling_rule(
	name, remark, implementation, implementation_transpiled, material_attribute_definition_id, production_unit_id)
	VALUES ('Scheduling Rule 1', 'Scheduling Rule Remark', '/**
  * context.currentLine: Current line which the rule will be applied
  * context.nextLine: Next line in the production sequence which the rule will be applied (Available depending on the material type)
  * Return => True: If violate any rule | False: Everything is OK
  */

function schedulingRule(context: Context): number {
  if (context.currentLine.SLAB_WIDTH_AIM > 1290) {
    return true;
  }
  return false;
}
', '/**
  * context.currentLine: Current line which the rule will be applied
  * context.nextLine: Next line in the production sequence which the rule will be applied (Available depending on the material type)
  * Return => True: If violate any rule | False: Everything is OK
  */
function schedulingRule(context) {
  if (context.currentLine.SLAB_WIDTH_AIM > 1290) {
    return true;
  }
  return false;
}
', 1, 2);

/*------------------------------------------------------------------------------------
Material Filter
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.material_filter(
	name, description, expression, is_default, production_unit_group_id
)
VALUES ('Material Filter 1', 'Material Filter 1 Description', '{"and":[{"==":[{"var":"11"},"080854-4"]}]}', true, 1),
  ('Material Filter 2', 'Material Filter 2 Description', '{"and":[{"==":[{"var":"11"},"080857-4"]}]}', false, 1);

/*------------------------------------------------------------------------------------
Material Filter Attribute
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.material_filter_attribute(
	material_filter_id, material_attribute_definition_id)
	VALUES (1, 1), (2, 1);

/*------------------------------------------------------------------------------------
Material
 ------------------------------------------------------------------------------------*/

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (18143.7, false, false, null, 1);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4535.9, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (17965.8, false, false, null, 1);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4491.4, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (19123.2, false, false, null, 1);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4780.8, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (17899.1, false, false, null, 1);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 3);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 3);

INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

 INSERT INTO ${pss_schema}.material(
	weight, is_placeholder, is_internally_calculated, unit_sequence_id, material_type_id)
	VALUES (4474.7, false, false, null, 2);

/*------------------------------------------------------------------------------------
Material Attribute
 ------------------------------------------------------------------------------------*/

--Heat Attributes

-- Heat 1
INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18143.7', null, null, 1, 1);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2000', null, null, 1, 2);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 1, 3);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('First Heat', null, null, 1, 4);

-- Slab 1

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,2, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,2, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,2, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,2, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4668', null, null,2, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,2, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-1', null, null,2, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,2, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,2, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,2, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,2, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,2, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,2, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,2, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,2, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,2, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.67599105834961', null, null,2, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('19.7768497467041', null, null,2, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,2, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,2, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,2, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1375', null, null,2, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1385', null, null,2, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1390', null, null,2, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1395', null, null,2, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1400', null, null,2, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1405', null, null,2, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1410', null, null,2, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,2, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,2, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,2, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,2, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,2, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,2, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,2, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,2, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,2, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,2, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,2, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,2, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,2, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,2, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('186596', null, null,2, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.7092108726501465', null, null,2, 54);

-- Slab 2

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,3, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,3, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,3, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,3, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4668', null, null,3, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,3, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-2', null, null,3, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,3, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,3, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,3, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,3, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,3, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,3, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,3, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,3, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,3, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.67599105834961', null, null,3, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('19.7768497467041', null, null,3, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,3, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,3, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,3, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1375', null, null,3, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1385', null, null,3, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1390', null, null,3, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1395', null, null,3, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1400', null, null,3, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1405', null, null,3, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1410', null, null,3, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,3, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,3, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,3, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,3, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,3, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,3, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,3, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,3, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,3, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,3, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,3, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,3, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,3, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,3, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('186596', null, null,3, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.7092108726501465', null, null,3, 54);

-- Slab 3

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,4, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,4, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,4, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,4, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4668', null, null,4, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,4, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-3', null, null,4, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,4, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,4, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,4, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,4, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,4, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,4, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,4, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,4, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,4, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.67599105834961', null, null,4, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('19.7768497467041', null, null,4, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,4, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,4, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,4, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1375', null, null,4, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1385', null, null,4, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1390', null, null,4, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1395', null, null,4, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1400', null, null,4, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1405', null, null,4, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1410', null, null,4, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,4, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,4, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,4, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,4, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,4, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,4, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,4, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,4, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,4, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,4, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,4, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,4, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,4, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,4, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('186596', null, null,4, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.7092108726501465', null, null,4, 54);

-- Slab 4

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,5, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,5, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,5, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,5, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4668', null, null,5, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,5, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-4', null, null,5, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,5, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,5, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1380', null, null,5, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,5, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,5, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,5, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,5, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,5, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,5, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.67599105834961', null, null,5, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('19.7768497467041', null, null,5, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,5, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,5, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,5, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1375', null, null,5, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1385', null, null,5, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1390', null, null,5, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1395', null, null,5, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1400', null, null,5, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1405', null, null,5, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1410', null, null,5, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,5, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,5, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,5, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,5, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,5, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,5, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,5, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,5, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,5, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,5, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,5, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,5, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,5, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,5, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('186596', null, null,5, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.7092108726501465', null, null,5, 54);


-- Coil 1

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,6, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,6, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,6, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,6, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,6, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4669', null, null,6, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,6, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-1', null, null,6, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1356.9300537109375', null, null,6, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1383.030029296875', null, null,6, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1344.9300537109375', null, null,6, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,6, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,6, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,6, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,6, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1132', null, null,6, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,6, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,6, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,6, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,6, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,6, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.3194992348844243', null, null,6, 85);

-- Coil 2

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,7, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,7, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,7, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,7, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,7, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4669', null, null,7, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,7, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-2', null, null,7, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1356.9300537109375', null, null,7, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1383.030029296875', null, null,7, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1344.9300537109375', null, null,7, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,7, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,7, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,7, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,7, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1132', null, null,7, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,7, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,7, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,7, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,7, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,7, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.3194992348844243', null, null,7, 85);

-- Coil 3

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,8, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,8, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,8, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,8, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,8, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4669', null, null,8, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,8, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-3', null, null,8, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1356.9300537109375', null, null,8, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1383.030029296875', null, null,8, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1344.9300537109375', null, null,8, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,8, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,8, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,8, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,8, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1132', null, null,8, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,8, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,8, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,8, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,8, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,8, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.3194992348844243', null, null,8, 85);

-- Coil 4

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,9, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498016', null, null,9, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,9, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,9, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850', null, null,9, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4669', null, null,9, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,9, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080850-4', null, null,9, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1356.9300537109375', null, null,9, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1383.030029296875', null, null,9, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1344.9300537109375', null, null,9, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,9, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,9, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,9, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1270.3453369140625', null, null,9, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1132', null, null,9, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,9, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,9, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,9, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,9, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,9, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.3194992348844243', null, null,9, 85);

-- Heat 2
INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17965.8', null, null, 10, 1);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2100', null, null, 10, 2);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 10, 3);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Some Remark about the Heat', null, null, 10, 4);

-- Slab 5

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,11, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,11, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,11, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,11, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4671', null, null,11, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,11, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-1', null, null,11, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,11, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,11, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,11, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,11, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,11, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,11, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,11, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,11, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,11, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,11, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,11, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,11, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,11, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,11, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,11, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,11, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,11, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,11, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,11, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,11, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,11, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,11, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,11, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,11, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,11, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,11, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,11, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,11, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,11, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,11, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,11, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,11, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,11, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,11, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,11, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,11, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,11, 54);

-- Slab 6

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,12, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,12, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,12, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,12, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4671', null, null,12, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,12, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-2', null, null,12, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,12, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,12, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,12, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,12, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,12, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,12, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,12, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,12, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,12, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,12, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,12, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,12, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,12, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,12, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,12, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,12, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,12, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,12, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,12, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,12, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,12, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,12, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,12, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,12, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,12, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,12, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,12, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,12, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,12, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,12, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,12, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,12, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,12, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,12, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,12, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,12, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,12, 54);

-- Slab 7

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,13, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,13, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,13, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,13, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4671', null, null,13, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,13, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-3', null, null,13, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,13, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,13, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,13, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,13, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,13, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,13, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,13, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,13, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,13, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,13, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,13, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,13, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,13, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,13, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,13, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,13, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,13, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,13, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,13, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,13, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,13, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,13, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,13, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,13, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,13, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,13, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,13, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,13, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,13, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,13, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,13, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,13, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,13, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,13, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,13, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,13, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,13, 54);

-- Slab 8

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,14, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,14, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,14, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,14, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4671', null, null,14, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,14, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-4', null, null,14, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,14, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,14, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,14, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,14, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,14, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,14, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,14, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,14, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,14, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,14, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,14, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,14, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,14, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,14, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,14, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,14, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,14, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,14, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,14, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,14, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,14, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,14, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,14, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,14, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,14, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,14, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,14, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,14, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,14, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,14, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,14, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,14, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,14, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,14, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,14, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,14, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,14, 54);

-- Coil 5

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,15, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,15, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,15, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,15, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,15, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4672', null, null,15, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,15, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-1', null, null,15, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,15, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,15, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,15, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,15, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,15, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,15, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,15, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,15, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,15, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,15, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,15, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,15, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,15, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,15, 85);

-- Coil 6

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,16, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,16, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,16, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,16, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,16, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4672', null, null,16, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,16, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-2', null, null,16, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,16, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,16, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,16, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,16, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,16, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,16, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,16, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,16, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,16, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,16, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,16, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,16, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,16, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,16, 85);

-- Coil 7

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,17, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,17, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,17, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,17, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,17, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4672', null, null,17, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,17, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-3', null, null,17, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,17, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,17, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,17, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,17, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,17, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,17, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,17, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,17, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,17, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,17, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,17, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,17, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,17, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,17, 85);

-- Coil 8

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,18, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498017', null, null,18, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,18, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,18, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851', null, null,18, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4672', null, null,18, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-21T00:00:00', null, null,18, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080851-4', null, null,18, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,18, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,18, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,18, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,18, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,18, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,18, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,18, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,18, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,18, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,18, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,18, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,18, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,18, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,18, 85);

-- Heat 3
INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('19123.2', null, null, 19, 1);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1900', null, null, 19, 2);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null, 19, 3);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES (null, null, null, 19, 4);


-- Slab 9

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,20, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,20, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,20, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,20, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4674', null, null,20, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,20, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-1', null, null,20, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,20, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,20, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,20, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,20, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,20, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,20, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,20, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,20, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,20, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,20, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,20, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,20, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,20, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,20, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,20, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,20, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,20, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,20, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,20, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,20, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,20, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,20, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,20, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,20, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,20, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,20, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,20, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,20, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,20, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,20, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,20, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,20, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,20, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,20, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,20, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,20, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,20, 54);

-- Slab 10

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,21, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,21, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,21, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,21, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4674', null, null,21, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,21, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-2', null, null,21, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,21, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,21, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,21, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,21, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,21, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,21, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,21, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,21, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,21, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,21, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,21, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,21, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,21, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,21, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,21, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,21, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,21, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,21, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,21, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,21, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,21, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,21, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,21, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,21, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,21, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,21, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,21, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,21, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,21, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,21, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,21, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,21, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,21, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,21, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,21, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,21, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,21, 54);

-- Slab 11

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,22, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,22, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,22, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,22, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4674', null, null,22, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,22, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-3', null, null,22, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,22, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,22, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,22, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,22, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,22, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,22, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,22, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,22, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,22, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,22, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,22, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,22, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,22, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,22, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,22, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,22, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,22, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,22, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,22, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,22, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,22, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,22, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,22, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,22, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,22, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,22, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,22, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,22, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,22, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,22, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,22, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,22, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,22, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,22, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,22, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,22, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,22, 54);

-- Slab 12

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,23, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,23, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,23, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,23, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4674', null, null,23, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,23, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-4', null, null,23, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,23, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,23, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1440', null, null,23, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,23, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,23, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,23, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,23, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,23, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,23, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.897825241088867', null, null,23, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.942575454711914', null, null,23, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('15', null, null,23, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,23, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,23, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1415', null, null,23, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1420', null, null,23, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1425', null, null,23, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1430', null, null,23, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1435', null, null,23, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,23, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,23, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,23, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,23, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,23, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,23, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,23, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,23, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,23, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,23, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,23, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,23, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,23, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,23, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,23, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,23, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('192150.09375', null, null,23, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.515282154083252', null, null,23, 54);

-- Coil 9

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,24, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,24, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,24, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,24, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,24, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4675', null, null,24, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,24, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-1', null, null,24, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,24, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,24, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,24, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,24, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,24, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,24, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,24, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,24, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,24, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,24, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,24, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,24, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,24, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,24, 85);

-- Coil 10

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,25, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,25, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,25, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,25, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,25, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4675', null, null,25, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,25, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-2', null, null,25, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,25, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,25, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,25, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,25, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,25, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,25, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,25, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,25, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,25, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,25, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,25, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,25, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,25, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,25, 85);

-- Coil 11

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,26, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,26, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,26, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,26, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,26, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4675', null, null,26, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,26, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-3', null, null,26, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,26, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,26, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,26, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,26, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,26, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,26, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,26, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,26, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,26, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,26, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,26, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,26, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,26, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,26, 85);

-- Coil 12

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,27, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498018', null, null,27, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,27, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,27, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852', null, null,27, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4675', null, null,27, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,27, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080852-4', null, null,27, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1396.81005859375', null, null,27, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1422.907958984375', null, null,27, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1384.8079833984375', null, null,27, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,27, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,27, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,27, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1234.0760498046875', null, null,27, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1100', null, null,27, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,27, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,27, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,27, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,27, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,27, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.253275800869676', null, null,27, 85);

-- Heat 4
INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17899.1', null, null, 28, 1);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2250', null, null, 28, 2);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 28, 3);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES (null, null, null, 28, 4);

-- Slab 13

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,29, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,29, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,29, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,29, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null,29, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,29, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-1', null, null,29, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,29, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,29, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,29, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,29, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,29, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,29, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,29, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,29, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,29, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null,29, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null,29, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null,29, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,29, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,29, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,29, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,29, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,29, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,29, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,29, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,29, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,29, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,29, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,29, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,29, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null,29, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null,29, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null,29, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null,29, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null,29, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null,29, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,29, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,29, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,29, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,29, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,29, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null,29, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null,29, 54);

-- Slab 14

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,30, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,30, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,30, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,30, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null,30, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,30, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-2', null, null,30, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,30, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,30, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,30, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,30, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,30, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,30, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,30, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,30, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,30, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null,30, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null,30, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null,30, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,30, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,30, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,30, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,30, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,30, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,30, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,30, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,30, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,30, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,30, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,30, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,30, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null,30, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null,30, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null,30, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null,30, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null,30, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null,30, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,30, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,30, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,30, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,30, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,30, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null,30, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null,30, 54);

-- Slab 15

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,31, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,31, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,31, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,31, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null,31, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,31, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-3', null, null,31, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,31, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,31, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,31, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,31, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,31, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,31, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,31, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,31, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,31, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null,31, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null,31, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null,31, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,31, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,31, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,31, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,31, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,31, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,31, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,31, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,31, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,31, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,31, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,31, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,31, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null,31, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null,31, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null,31, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null,31, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null,31, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null,31, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,31, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,31, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,31, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,31, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,31, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null,31, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null,31, 54);

-- Slab 16

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,32, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,32, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,32, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,32, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null,32, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,32, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-4', null, null,32, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,32, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,32, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null,32, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,32, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,32, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null,32, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,32, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,32, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null,32, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null,32, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null,32, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null,32, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,32, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,32, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null,32, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null,32, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null,32, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null,32, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null,32, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null,32, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null,32, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null,32, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null,32, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null,32, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null,32, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null,32, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null,32, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null,32, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null,32, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null,32, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null,32, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,32, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,32, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null,32, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,32, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null,32, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null,32, 54);


-- Coil 13

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,33, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,33, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,33, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,33, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,33, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4678', null, null,33, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,33, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-1', null, null,33, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1426.780029296875', null, null,33, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1452.8800048828125', null, null,33, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1414.780029296875', null, null,33, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,33, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,33, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,33, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,33, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1077', null, null,33, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,33, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,33, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,33, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,33, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,33, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.2059452074198798', null, null,33, 85);

-- Coil 14

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,34, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,34, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,34, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,34, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,34, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4678', null, null,34, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,34, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-2', null, null,34, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1426.780029296875', null, null,34, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1452.8800048828125', null, null,34, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1414.780029296875', null, null,34, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,34, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,34, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,34, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,34, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1077', null, null,34, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,34, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,34, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,34, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,34, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,34, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.2059452074198798', null, null,34, 85);


-- Coil 15

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,35, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,35, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,35, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,35, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,35, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4678', null, null,35, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,35, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-3', null, null,35, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1426.780029296875', null, null,35, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1452.8800048828125', null, null,35, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1414.780029296875', null, null,35, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,35, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,35, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,35, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,35, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1077', null, null,35, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,35, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,35, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,35, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,35, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,35, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.2059452074198798', null, null,35, 85);


-- Coil 16

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null,36, 56);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null,36, 57);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,36, 58);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('0', null, null,36, 59);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null,36, 60);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4678', null, null,36, 61);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-08-28T00:00:00', null, null,36, 62);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853-4', null, null,36, 63);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1426.780029296875', null, null,36, 64);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1452.8800048828125', null, null,36, 65);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1414.780029296875', null, null,36, 66);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1.5399999618530273', null, null,36, 67);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null,36, 70);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,36, 73);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1208.1539306640625', null, null,36, 74);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1077', null, null,36, 75);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null,36, 76);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null,36, 77);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null,36, 82);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('999999', null, null,36, 83);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null,36, 84);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2.2059452074198798', null, null,36, 85);

-- Slab 17

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null, 37, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null, 37, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null, 37, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null, 37, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null, 37, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-10-13', null, null, 37, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080854-4', null, null, 37, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 37, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 37, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 37, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 37, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 37, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 37, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 37, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 37, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null, 37, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null, 37, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null, 37, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null, 37, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 37, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null, 37, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null, 37, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null, 37, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null, 37, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null, 37, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null, 37, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null, 37, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null, 37, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null, 37, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null, 37, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null, 37, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null, 37, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null, 37, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null, 37, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null, 37, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null, 37, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null, 37, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null, 37, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 37, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 37, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 37, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null, 37, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null, 37, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null, 37, 54);

-- Slab 18

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null, 38, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null, 38, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null, 38, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null, 38, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null, 38, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-10-18', null, null, 38, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080855-4', null, null, 38, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 38, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 38, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 38, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 38, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 38, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 38, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 38, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 38, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null, 38, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null, 38, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null, 38, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null, 38, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 38, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null, 38, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null, 38, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null, 38, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null, 38, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null, 38, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null, 38, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null, 38, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null, 38, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null, 38, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null, 38, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null, 38, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null, 38, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null, 38, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null, 38, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null, 38, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null, 38, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null, 38, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null, 38, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 38, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 38, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 38, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null, 38, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null, 38, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null, 38, 54);

-- Slab 17

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null, 39, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null, 39, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null, 39, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null, 39, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null, 39, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-10-20', null, null, 39, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080856-4', null, null, 39, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 39, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 39, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 39, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 39, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 39, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 39, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 39, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 39, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null, 39, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null, 39, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null, 39, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null, 39, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 39, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null, 39, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null, 39, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null, 39, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null, 39, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null, 39, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null, 39, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null, 39, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null, 39, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null, 39, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null, 39, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null, 39, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null, 39, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null, 39, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null, 39, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null, 39, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null, 39, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null, 39, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null, 39, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 39, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 39, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 39, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null, 39, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null, 39, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null, 39, 54);

-- Slab 19

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null, 40, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null, 40, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null, 40, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null, 40, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null, 40, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-10-15', null, null, 40, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080857-4', null, null, 40, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 40, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 40, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 40, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 40, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 40, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 40, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 40, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 40, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null, 40, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null, 40, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null, 40, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null, 40, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 40, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null, 40, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null, 40, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null, 40, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null, 40, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null, 40, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null, 40, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null, 40, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null, 40, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null, 40, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null, 40, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null, 40, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null, 40, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null, 40, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null, 40, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null, 40, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null, 40, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null, 40, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null, 40, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 40, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 40, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 40, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null, 40, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null, 40, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null, 40, 54);

-- Slab 20

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Interlake Mecalux - Melrose Pk', null, null, 41, 5);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('498019', null, null, 41, 6);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1', null, null, 41, 7);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080853', null, null, 41, 8);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('4677', null, null, 41, 9);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('2021-10-28', null, null, 41, 10);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('080858-4', null, null, 41, 11);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 41, 12);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 41, 13);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1470', null, null, 41, 14);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 41, 15);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 41, 16);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('103', null, null, 41, 17);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 41, 18);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('20865.19921875', null, null, 41, 19);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18597.30078125', null, null, 41, 20);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('17.532564163208008', null, null, 41, 21);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('18.54886817932129', null, null, 41, 22);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('14', null, null, 41, 23);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1008VN21', null, null, 41, 24);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('HV45FL02', null, null, 41, 25);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1445', null, null, 41, 26);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1450', null, null, 41, 27);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1455', null, null, 41, 28);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1460', null, null, 41, 29);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1465', null, null, 41, 30);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1475', null, null, 41, 31);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1480', null, null, 41, 32);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1485', null, null, 41, 33);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1490', null, null, 41, 34);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1495', null, null, 41, 35);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1500', null, null, 41, 36);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1505', null, null, 41, 37);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1510', null, null, 41, 38);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1515', null, null, 41, 39);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1520', null, null, 41, 40);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('1525', null, null, 41, 41);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('Y', null, null, 41, 44);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 41, 45);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 41, 46);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('N', null, null, 41, 47);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('NoTr', null, null, 41, 52);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('194769.203125', null, null, 41, 53);

INSERT INTO ${pss_schema}.material_attribute(
	value, min, max, material_id, material_attribute_definition_id)
	VALUES ('6.427670001983643', null, null, 41, 54);
 /*------------------------------------------------------------------------------------
 Group Sequence
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.group_sequence (
    name, start_date, remark, planning_status, execution_status, production_unit_group_id, predecessor_sequence_id, successor_sequence_id)
	VALUES('SEQ-20210804', TIMESTAMP WITH TIME ZONE '2021-07-15 12:35:22-03', 'Time, Days M-F only', 'PLANNING', 'NOT STARTED', 1, null, null);

 /*------------------------------------------------------------------------------------
Sequence Scenario
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.sequence_scenario (
    name, remark, rating, group_sequence_id, selected, deleted, material_filter_id, planning_horizon_id, optimizer_setup_id)
	VALUES
	('SEQ-20210804-SC-1', 'Still working on it', 4, 1, false, false, 1, 1, null);

INSERT INTO ${pss_schema}.sequence_scenario (
    name, remark, rating, group_sequence_id, selected, deleted, material_filter_id, planning_horizon_id, optimizer_setup_id)
	VALUES
	('SEQ-20210804-SC-2', 'Greater rating scenario', 3, 1, false, false, 1, 1, null);

 /*------------------------------------------------------------------------------------
Sequence Scenario Version
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.sequence_scenario_version (
    name, remark, sequence_scenario_id, kpi_id)
	VALUES
	('1', null, 1, null);

INSERT INTO ${pss_schema}.sequence_scenario_version (
    name, remark, sequence_scenario_id, kpi_id)
	VALUES
	('1', null, 2, null);

 /*------------------------------------------------------------------------------------
Unit Sequence
 ------------------------------------------------------------------------------------*/

INSERT INTO ${pss_schema}.unit_sequence(
	sequence_scenario_version_id, production_unit_id)
	VALUES
	(1, 1);

INSERT INTO ${pss_schema}.unit_sequence(
	sequence_scenario_version_id, production_unit_id)
	VALUES
	(1, 2);

INSERT INTO ${pss_schema}.unit_sequence(
	sequence_scenario_version_id, production_unit_id)
	VALUES
	(1, 3);

INSERT INTO ${pss_schema}.unit_sequence(
	sequence_scenario_version_id, production_unit_id)
	VALUES
	(2, 1);

INSERT INTO ${pss_schema}.unit_sequence(
	sequence_scenario_version_id, production_unit_id)
	VALUES
	(2, 2);

INSERT INTO ${pss_schema}.unit_sequence(
	sequence_scenario_version_id, production_unit_id)
	VALUES
	(2, 3);

 /*------------------------------------------------------------------------------------
Sequence Item
 ------------------------------------------------------------------------------------*/

--- Sequence Scenario version 1

INSERT INTO ${pss_schema}.sequence_item ( --Caster 1 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(1, 1);

INSERT INTO ${pss_schema}.sequence_item ( --Caster 1 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(2, 1);

INSERT INTO ${pss_schema}.sequence_item ( --Caster 2 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(1, 2);

INSERT INTO ${pss_schema}.sequence_item ( --Caster 2 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(2, 2);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(1, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(2, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(3, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(4, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(5, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(6, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(7, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(8, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(9, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(10, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(11, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(12, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(13, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(14, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(15, 3);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(16, 3);


--- Sequence Scenario version 2

INSERT INTO ${pss_schema}.sequence_item ( --Caster 1 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(1, 4);

INSERT INTO ${pss_schema}.sequence_item ( --Caster 1 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(2, 4);

INSERT INTO ${pss_schema}.sequence_item ( --Caster 2 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(1, 5);

INSERT INTO ${pss_schema}.sequence_item ( --Caster 2 Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(2, 5);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(1, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(2, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(3, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(4, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(5, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(6, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(7, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(8, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(9, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(10, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(11, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(12, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(13, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(14, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(15, 6);

INSERT INTO ${pss_schema}.sequence_item ( --HSM Sequence Item
    item_order, unit_sequence_id)
	VALUES
	(16, 6);

 /*------------------------------------------------------------------------------------
Input Material
 ------------------------------------------------------------------------------------*/

--Sequence Scenario Version 1

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 1, 1);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 2, 10);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 3, 19);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 4, 28);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 5, 2);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 6, 3);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 7, 4);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 8, 5);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 9, 11);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 10, 12);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 11, 13);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 12, 14);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 13, 20);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 14, 21);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 15, 22);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 16, 23);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 17, 29);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 18, 30);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 19, 31);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 20, 32);

--Sequence Scenario Version 2

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 21, 1);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 22, 10);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 23, 19);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 24, 28);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 25, 2);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 26, 3);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 27, 4);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 28, 5);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 29, 11);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 30, 12);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 31, 13);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 32, 14);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 33, 20);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 34, 21);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 35, 22);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 36, 23);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 37, 29);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 38, 30);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 39, 31);

INSERT INTO ${pss_schema}.input_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 40, 32);

  /*------------------------------------------------------------------------------------
Output Material
 ------------------------------------------------------------------------------------*/

--Sequence Scenario Version 1

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 1, 2);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 1, 3);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 1, 4);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 1, 5);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 2, 11);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 2, 12);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 2, 13);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 2, 14);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 3, 20);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 3, 21);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 3, 22);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 3, 23);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 4, 29);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 4, 30);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 4, 31);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 4, 32);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 5, 6);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 6, 7);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 7, 8);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 8, 9);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(5, 9, 15);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(6, 10, 16);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(7, 11, 17);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(8, 12, 18);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(9, 13, 24);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(10, 14, 25);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(11, 15, 26);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(12, 16, 27);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(13, 17, 33);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(14, 18, 34);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(15, 19, 35);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(16, 20, 36);



--Sequence Scenario Version 2

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 21, 2);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 21, 3);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 21, 4);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 21, 5);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(5, 21, 37);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 22, 11);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 22, 12);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 22, 13);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 22, 14);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 23, 20);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 23, 21);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 23, 22);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 23, 23);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 24, 29);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 24, 30);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 24, 31);

 INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 24, 32);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(2, 25, 6);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(1, 26, 7);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(3, 27, 8);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(4, 28, 9);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(7, 29, 15);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(6, 30, 16);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(5, 31, 17);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(8, 32, 18);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(9, 33, 24);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(10, 34, 25);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(11, 35, 26);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(12, 36, 27);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(16, 37, 33);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(14, 38, 34);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(13, 39, 35);

INSERT INTO ${pss_schema}.output_material (
    material_order, sequence_item_id, material_id)
	VALUES
	(15, 40, 36);


