namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class SchedulingRuleViolationQuery
    {
        public static string GetImplementationForInputMaterial => @"
            select 
                sr.id,
                sr.implementation,
                sr.implementation_transpiled as ImplementationTranspiled
            from pss.unit_sequence us 
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.production_unit_material_type pumt 
                    on pu.id = pumt.production_unit_id 
                inner join pss.material_type mt 
                    on pumt.material_type_id = mt.id 
                inner join pss.material_attribute_definition mad 
                    on mt.id = mad.material_type_id 
                inner join pss.scheduling_rule sr 
                    on pu.id = sr.production_unit_id 
                    and mad.id = sr.material_attribute_definition_id 
            where 
                us.id = @unitSequenceId 
                    and 
                pumt.is_input is true
        ";
        public static string GetImplementationForOutputMaterial => @"
            select 
                sr.id,
                sr.implementation,
                sr.implementation_transpiled as ImplementationTranspiled
            from pss.unit_sequence us 
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.production_unit_material_type pumt 
                    on pu.id = pumt.production_unit_id 
                inner join pss.material_type mt 
                    on pumt.material_type_id = mt.id 
                inner join pss.material_attribute_definition mad 
                    on mt.id = mad.material_type_id 
                inner join pss.scheduling_rule sr 
                    on pu.id = sr.production_unit_id 
                    and mad.id = sr.material_attribute_definition_id 
            where 
                us.id = @unitSequenceId 
                    and 
                pumt.is_output is true
        ";
        public static string InsertSchedulingRuleViolation => @"
            insert into pss.scheduling_rule_violation
            (
                scheduling_rule_id, 
                sequence_item_id, 
                position_from, 
                position_to
            )
            values (
                @schedulingRuleId, 
                @sequenceItemId, 
                @currentMaterialPos, 
                @currentMaterialPos
            );
        ";
        public static string DeleteSchedulingRuleViolation => @"
            delete from 
                pss.scheduling_rule_violation_suppression srvs 
            where 
                srvs.scheduling_rule_violation_id in (
                    select 
                        id 
                    from 
                        pss.scheduling_rule_violation srv
                    where 
                        sequence_item_id = @sequenceItemId
                            and
                        scheduling_rule_id = @schedulingRuleId
                            and
                        position_from = @position
                );
                
            delete from 
                pss.scheduling_rule_violation
            where 
                sequence_item_id = @sequenceItemId
                    and
                scheduling_rule_id = @schedulingRuleId
                    and
                position_from = @position;
        ";
        public static string DeleteRuleViolationBySequenceItem => @"
            delete from 
                pss.scheduling_rule_violation
            where 
                sequence_item_id = @sequenceItemId;
        ";
        public static string GetComboBySequenceItem => @"
            select
                srv.id as Id,
                mad.name
            from
                pss.scheduling_rule_violation srv 
                    inner join pss.scheduling_rule sr
                        on srv.scheduling_rule_id = sr.id 
                    inner join pss.material_attribute_definition mad 
                        on sr.material_attribute_definition_id = mad.id
                    left join pss.scheduling_rule_violation_suppression srvs 
                        on srv.id = srvs.scheduling_rule_violation_id
            where
                srvs.id is null
                    and
                srv.sequence_item_id = @sequenceItemId
                    and
                (
                    srv.position_from = @position
                        or
                    srv.position_to = @position
                );
        ";
        public static string InsertRuleViolationSuppression => @"
            insert into pss.scheduling_rule_violation_suppression
            (
                responsible, 
                scheduling_rule_violation_id
            )
            values (
                @responsible, 
                @schedulingRuleViolationId
            );
        ";
        public static string GetViolationForMaterial => @"
            with c as (
                select 
                    srv.id as RuleViolationId,
                    mad.id as MaterialAttributeDefinitionId,
                    mad.name as MaterialAttributeDefinitionName,
                    srv.sequence_item_id as SequenceItemId,
                    srv.position_from as RuleViolationPositionFrom,
                    srv.position_to as RuleViolationPositionTo
                from 
                    pss.scheduling_rule_violation srv 
                        inner join pss.scheduling_rule sr 
                            on srv.scheduling_rule_id = sr.id 
                        inner join pss.material_attribute_definition mad 
                            on sr.material_attribute_definition_id = mad.id 
                        left join pss.scheduling_rule_violation_suppression srvs 
                            on srv.id = srvs.scheduling_rule_violation_id 
                where 
                    srvs.id is null
                        and
                    srv.sequence_item_id = @sequenceItemId
                        and
                    srv.position_from = @position
                order by
                    mad.id
            )
            select 
                cast(
                    json_build_object(
                        'ruleViolationId', RuleViolationId,
                        'materialAttributeDefinitionId', MaterialAttributeDefinitionId,
                        'materialAttributeDefinitionName', MaterialAttributeDefinitionName,
                        'sequenceItemId', SequenceItemId,
                        'ruleViolationPositionFrom', RuleViolationPositionFrom,
                        'ruleViolationPositionTo', RuleViolationPositionTo
                    ) as json
                ) as data
            from c;
        ";
    }
}