namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class OptimizerIntegrationQuery
    {
        public static string GetStatusIntegration => @"
            select oi.task_running as TaskRunning
            from pss.optimizer_integration oi;
        ";

        public static string SetNewIntegration => @"
            insert into pss.optimizer_integration
            (
	            task_running
            )
	        values 
            (
                false
            );
        ";
        public static string SetTaskStatus => @"
            update pss.optimizer_integration
               set task_running = @Status
        ";

        public static string GetCountIntegration => @"
            select Count(*) 
              From pss.optimizer_integration
        ";
    }
}