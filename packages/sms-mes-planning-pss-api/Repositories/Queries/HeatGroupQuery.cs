namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class HeatGroupQuery
    {
        public static string GetById => @"
            select hg.Id                   as Id,
                   hg.group_number         as GroupNumber,
                   hg.unit_sequence_id     as UnitSequenceId,
                   hg.heat_steel_grade_int as HeatSteelGradeInt
              from pss.heat_group hg 
             where hg.id = @heatGroupId;
        ";

        public static string GetByGroupNumber => @"
            select hg.Id                   as Id,
                   hg.group_number         as GroupNumber,
                   hg.unit_sequence_id     as UnitSequenceId,
                   hg.heat_steel_grade_int as HeatSteelGradeInt
              from pss.heat_group hg 
             where hg.group_number = @groupNumber;
        ";
        public static string Add => @"
            INSERT INTO pss.heat_group
            (
                group_number,
                unit_sequence_id,                
                heat_steel_grade_int
            )
            VALUES
            (
                @group_number,
                @unit_sequence_id,                
                @heat_steel_grade_int
            )
            RETURNING id
        ";
        public static string GetHeatAtributesByGroupNumber => @"
            select hg.heat_steel_grade_int as HeatSteelGradeInt                   
              from pss.heat_group hg 
             where hg.group_number = @groupNumber
          Group By hg.heat_steel_grade_int;
        ";

        public static string Delete => @"
            Delete From pss.heat_group
             Where id = @id
        ";

        public static string Update => @"
            Update pss.heat_group
               Set heat_steel_grade_int = @heatSteelGradeInt
             Where group_number         = @groupNumber
               And unit_sequence_id     = @unitSequenceId
        ";

        public static string GetNextGroupNumber => @"
            Select COALESCE(Max(hg.group_number),0) + 1
              From pss.heat_group hg
        ";
    }
}