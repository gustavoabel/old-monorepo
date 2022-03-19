namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class GroupSequenceQuery
    {
        public static string Add => @"
             INSERT INTO pss.group_sequence
             (
	            name, 
                start_date, 
                remark, 
                planning_status, 
                execution_status,
                production_unit_group_id, 
                predecessor_sequence_id,
                successor_sequence_id
            )
	        VALUES 
            (
                @name, 
                @start_date, 
                @remark, 
                cast(@planning_status as pss.planning_status), 
                cast(@execution_status as pss.execution_status), 
                @production_unit_group_id, 
                @predecessor_sequence_id,
                @successor_sequence_id
            ) RETURNING id";

        public static string GetAll => @"
            SELECT id,
            production_unit_group_id as productionUnitGroupId,
            name,
            start_date as startDate,
            remark,
            cast(planning_status as text) as planningStatus
            FROM pss.group_sequence
            WHERE 
                planning_status != 'DELETED' 
                AND execution_status != 'DELETED'";

        public static string GetById => @"
            SELECT id,
            name,
            start_date as startDate,
            cast(planning_status as text) as planningStatus,
            production_unit_group_id as productionUnitGroupId
            FROM pss.group_sequence
            WHERE 
                id = @id
                AND planning_status != 'DELETED' 
                AND execution_status != 'DELETED'";

        public static string GetSequenceByScenarioId => @"
        SELECT gs.id,
            gs.production_unit_group_id as productionUnitGroupId,
            gs.name,
            gs.start_date as startDate,
            gs.remark,
            cast(gs.planning_status as text) as planningStatus
            FROM pss.group_sequence gs
            inner join pss.sequence_scenario ss
            	on ss.group_sequence_id = gs.id 
            WHERE 
            ss.id = @id and
                gs.planning_status != 'DELETED' 
                AND gs.execution_status != 'DELETED'
        ";

        public static string Update => @"
            UPDATE pss.group_sequence
            SET 
            name = @name, 
            start_date = @start_date, 
            remark = @remark, 
            predecessor_sequence_id = @predecessor_sequence_id,
            successor_sequence_id = @successor_sequence_id
            WHERE id = @id
        ";

        public static string Delete => @"
            UPDATE pss.group_sequence
            SET 
            planning_status = cast('DELETED' as pss.planning_status), 
            execution_status = cast('DELETED' as pss.execution_status)
            WHERE id = @id
        ";

        public static string ChangeGroupSequenceStatus => @"
            UPDATE pss.group_sequence
            SET planning_status =  cast(@planningStatus as pss.planning_status)
            WHERE id = @id";
    }
}