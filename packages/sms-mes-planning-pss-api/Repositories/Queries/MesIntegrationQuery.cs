namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class MesIntegrationQuery
    {
        public static string GetLastIntegration => @"
            select 
                max(last_integration) as LastIntegration
            from 
                pss.mes_integration mi
            where
                integration_type = cast(@type as pss.mes_integration_type);
        ";

        public static string SetIntegrationTime => @"
            insert into pss.mes_integration
             (
                integration_type,
	            last_integration
            )
	        values 
            (
                cast(@type as pss.mes_integration_type),
                now()
            );
        ";

        public static string UpdateIntegrationTime => @"
            UPDATE 
                pss.mes_integration
            SET 
                last_integration = now()
            WHERE
                integration_type = cast(@type as pss.mes_integration_type);
        ";
    }
}