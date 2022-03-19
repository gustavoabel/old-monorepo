namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class SequenceScenarioVersionQuery
    {
        public static string Add => @"
            INSERT INTO pss.sequence_scenario_version
            (
                name,
                remark,
                sequence_scenario_id
            )
	        VALUES 
            (
                @name,
                @remark,
                @sequence_scenario_id
            )  RETURNING id";
    }
}