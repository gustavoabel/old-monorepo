namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class SendToMESQuery
    {
        public static string GetMesProgram => @"
            select ROUND(sum(cast(ma.value as float)))::text as Duration,
                   gs.remark                                 as Remark, 
                   gs.start_date                             as StartDate
              from pss.group_sequence gs 
	    inner join pss.sequence_scenario ss 
		        on gs.id = ss.group_sequence_id 
	    inner join pss.sequence_scenario_version ssv 
		        on ss.id = sequence_scenario_id 
	    inner join pss.unit_sequence us 
		        on ssv.id = us.sequence_scenario_version_id 
	    inner join pss.sequence_item si 
		        on us.id = si.unit_sequence_id 
	    inner join pss.output_material om 
		        on si.id = om.sequence_item_id 
	    inner join pss.material m2 
		        on om.material_id = m2.id 
	    inner join pss.material_attribute ma 
		        on m2.id = ma.material_id 
        inner join pss.production_unit_group pug 
		        on gs.production_unit_group_id = pug.id 	
	    inner join pss.production_unit pu 
		        on pug .id = pu .production_unit_group_id 
             where gs.id                               = @groupSequenceId
	           and ssv.id                              = @sequenceScenarioVersionId
	           and us.production_unit_id               = @productionUnitId
	           and ma.material_attribute_definition_id = 54 
          Group By gs.remark, gs.start_date
        ";

        public static string GetDurationProgramLine => @"
            select ROUND(sum(cast(ma.value as float)))::text as Duration
              from pss.group_sequence gs 
	    inner join pss.sequence_scenario ss 
		        on gs.id = ss.group_sequence_id 
	    inner join pss.sequence_scenario_version ssv 
		        on ss.id = sequence_scenario_id 
	    inner join pss.unit_sequence us 
		        on ssv.id = us.sequence_scenario_version_id 
	    inner join pss.sequence_item si 
		        on us.id = si.unit_sequence_id 
	    inner join pss.output_material om 
		        on si.id = om.sequence_item_id 
	    inner join pss.material m2 
		        on om.material_id = m2.id 
	    inner join pss.material_attribute ma 
		        on m2.id = ma.material_id 
        inner join pss.production_unit_group pug 
		        on gs.production_unit_group_id = pug.id 	
	    inner join pss.production_unit pu 
		        on pug .id = pu .production_unit_group_id 
             where gs.id                               = @groupSequenceId
	           and ssv.id                              = @sequenceScenarioVersionId
	           and us.production_unit_id               = @productionUnitId
               and pu.id                               = @productionUnitId
	           and ma.material_attribute_definition_id = 54 
          Group By gs.remark, gs.start_date
        ";
    }
}