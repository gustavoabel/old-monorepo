namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class SequenceScenarioQuery
    {
        public static string GetByUnitSequenceId => @"
            select
                ss.id,
                ss.name,
                ss.remark,
                ss.rating,
                ss.selected,
                ss.useOptimizer
            from
                pss.unit_sequence us
                    inner join pss.sequence_scenario_version ssv
                        on us.sequence_scenario_version_id = ssv.id
                    inner join pss.sequence_scenario ss
                        on ssv.sequence_scenario_id = ss.id
            where
                ss.deleted = false
                    and
                us.id = @unitSequenceId;
        ";
        public static string Add => @"
            INSERT INTO pss.sequence_scenario
            (
                name,
                remark,
                rating,
                group_sequence_id,
                material_filter_id,
                planning_horizon_id,
                is_optimized
            )
	        VALUES 
            (
                @name,
                @remark,
                @rating,
                @group_sequence_id,
                @material_filter_id,
                @planning_horizon_id,
                @is_optimized
            ) RETURNING id";

        public static string GetByGroupSequenceId => @"
            select
                ss.id,
                ss.name,
                ss.remark,
                ss.rating,
                ss.selected,
                ss.group_sequence_id as groupSequenceId,
                gs.name as groupSequenceName,
                ss.material_filter_id as materialFilterId,
                mf.name as materialFilterName,
                coalesce(mc.materials_count, 0) as materials,
                coalesce(rvc.rule_violation_count, 0) as ruleViolation,
                ss.planning_horizon_id as planningHorizonId,
                ss.is_optimized as isOptimized
                from
                    pss.sequence_scenario ss
                        inner join pss.group_sequence gs
                            on gs.id = ss.group_sequence_id
                        inner join pss.material_filter mf
                            on ss.material_filter_id = mf.id
                        left join (
                            select
                            ss.id,
                            count(si.id) as materials_count
                from
                    pss.sequence_scenario ss
                        inner join pss.sequence_scenario_version ssv
                            on ss.id = ssv.sequence_scenario_id
                        inner join pss.unit_sequence us
                            on ssv.id = us.sequence_scenario_version_id
                        inner join pss.sequence_item si
                            on us.id = si.unit_sequence_id
                        inner join pss.production_unit pu
                            on us.production_unit_id = pu.id
                        inner join pss.production_unit_type put
                            on pu.production_unit_type_id = put.id
                group by
                    ss.id, put.name
                having
                    lower(put.name) like '%hsm%'
                ) mc
                    on ss.id = mc.id
                left join (
                    select
                        ss.id,
                        count(srv.id) as rule_violation_count
                    from
                        pss.sequence_scenario ss
                        inner join pss.sequence_scenario_version ssv
                            on ss.id = ssv.sequence_scenario_id
                        inner join pss.unit_sequence us
                            on ssv.id = us.sequence_scenario_version_id
                        inner join pss.sequence_item si
                            on us.id = si.unit_sequence_id
                        inner join pss.scheduling_rule_violation srv
                            on si.id = srv.sequence_item_id
                        left join pss.scheduling_rule_violation_suppression srvs
                            on srv.id = srvs.scheduling_rule_violation_id
                    group by
                        ss.id, srvs.id
                    having
                        srvs.id is null
                ) rvc
                on ss.id = rvc.id
                where
                deleted = false
        ";
        public static string GetBySequenceItemId => @"
        select
            ss.id,
            ss.name,
            ss.remark,
            ss.rating,
            ss.selected
        from
            pss.sequence_item si
                inner join pss.unit_sequence us
                    on si.unit_sequence_id = us.id
                inner join pss.sequence_scenario_version ssv
                    on us.sequence_scenario_version_id = ssv.id
                inner join pss.sequence_scenario ss
                    on ssv.sequence_scenario_id = ss.id
        where
            ss.deleted = false
                and
            si.id = @sequenceItemId;
    ";

        public static string GetDuplicate => @"
            SELECT id,
            name,
            remark,
            rating,
            group_sequence_id as groupSequenceId,
            material_filter_id as materialFilterId,
            planning_horizon_id as planningHorizonId
            FROM pss.sequence_scenario
            WHERE group_sequence_id = @groupSequenceId
            AND material_filter_id = @materialFilterId
            AND planning_horizon_id = @planningHorizonId
            AND deleted = false
        ";

        public static string Delete => @"
            UPDATE pss.sequence_scenario
            SET deleted = true
            WHERE id = @id
        ";

        public static string CountScenarios => @"
            select COUNT(*)
            from pss.group_sequence gs
            inner join pss.sequence_scenario ss on gs.id = ss.group_sequence_id 
            where gs.id = @groupSequenceId and ss.deleted = false
        ";

        public static string GetGroupSequenceIdByScenarioId => @"
            select group_sequence_id
            from pss.sequence_scenario
            where id = @id
        ";

        public static string Update => @"
            UPDATE pss.sequence_scenario
            SET name = @name,
            remark = @remark,
            rating = @rating,
            material_filter_id = @materialFilterId,
            planning_horizon_id = @planningHorizonId
            WHERE id = @id
        ";

        public static string ChangeSelectedScenario => @"
        UPDATE pss.sequence_scenario
        SET selected = false
        WHERE group_sequence_id = @groupSequenceId;

        UPDATE pss.sequence_scenario
        SET selected = true
        WHERE id = @id;
    ";
        public static string GetSelectedSequenceScenario => @"
        Select ss.id
          From pss.sequence_scenario ss
         WHERE ss.selected = true;
    ";

        public static string GetPedingOptimizedSequences => @"
        select ss.id                   as Id,
               ss.group_sequence_id    as GroupSequenceId,
               ss.material_filter_id   as MaterialFilterId,
               ss.planning_horizon_id  as PlanningHorizonId
          from pss.sequence_scenario ss
         where ss.is_optimized = false;
    ";

        public static string ChangeOptimizedScenario => @"
        UPDATE pss.sequence_scenario
           SET is_optimized = true
         WHERE id                  = @sequenceScenarioId
           and group_sequence_id   = @groupSequenceId
           and material_filter_id  = @materialFilterId
           and planning_horizon_id = @planningHorizonId;
    ";

    }
}