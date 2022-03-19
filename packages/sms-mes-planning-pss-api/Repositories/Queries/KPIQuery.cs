namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class KPIQuery
    {
        public static string GetBySequenceScenarioId => @"
            SELECT materials.materialId,
							materials.materialTypeName,
							materials.pieceId,
							COALESCE(materials.slabWidth,materials.coilWidth) as width,
							COALESCE(materials.slabThickness, materials.coilThickness) as thickness,
							COALESCE(materials.slabWeight, materials.coilWeight) as weight,
							COALESCE(materials.slabLength, materials.coilLength) as length,
							materials.steelGrade,
							COALESCE(materials.slabProductionTime, materials.coilProductionTime) as productionTime
						FROM
						crosstab(
							format(
							$$
								SELECT m.id material_id,
								mt.name material_type_name,
								mad.name,
								ma.value
								FROM pss.material m
								INNER JOIN pss.material_attribute ma ON ma.material_id = m.id
								INNER JOIN pss.material_type mt ON mt.id = m.material_type_id
								INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
								WHERE m.id IN (
									SELECT im.material_id
									FROM pss.sequence_scenario ss
									INNER JOIN pss.sequence_scenario_version ssv ON ssv.sequence_scenario_id = ss.id
									INNER JOIN pss.unit_sequence us ON us.sequence_scenario_version_id = ssv.id
									INNER JOIN pss.sequence_item si ON si.unit_sequence_id = us.id
									INNER JOIN pss.input_material im ON im.sequence_item_id = si.id
									WHERE ss.id = %s

									UNION

									SELECT om.material_id
									FROM pss.sequence_scenario ss
									INNER JOIN pss.sequence_scenario_version ssv ON ssv.sequence_scenario_id = ss.id
									INNER JOIN pss.unit_sequence us ON us.sequence_scenario_version_id = ssv.id
									INNER JOIN pss.sequence_item si ON si.unit_sequence_id = us.id
									INNER JOIN pss.output_material om ON om.sequence_item_id = si.id
									WHERE ss.id = %s
								) ORDER  BY 1,2
							$$
							, @sequenceScenarioId, @sequenceScenarioId),
							$$ 
								VALUES
								('PS_PIECE_ID'),
								('SLAB_WIDTH_AIM'),
								('COIL_WIDTH_AIM'),
								('SLAB_THICKNESS_AIM'),
								('COIL_THICKNESS_AIM'),
								('SLAB_WEIGHT_AIM'),
								('COIL_WEIGHT_AIM'),
								('SLAB_LENGTH_AIM'),
								('COIL_LENGTH_AIM'),
								('STEEL_GRADE_INT'),
								('PERFORMANCE_DUR'),
								('DURATION')
							$$
						) as materials (
							materialId int,
							materialTypeName text,
							pieceId text, 
							slabWidth decimal, 
							coilWidth decimal, 
							slabThickness decimal,
							coilThickness decimal,
							slabWeight decimal,
							coilWeight decimal,
							slabLength decimal,
							coilLength decimal,
							steelGrade text,
							slabProductionTime decimal,
							coilProductionTime decimal
						)
        ";
    }
}