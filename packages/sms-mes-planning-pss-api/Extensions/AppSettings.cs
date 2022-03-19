namespace sms_mes_planning_pss_api.Extensions
{
    public class AppSettings
    {
        public string Secret { get; set; }
        public int ExpiresIn { get; set; }
        public string Issuer { get; set; }
        public string Audience { get; set; }
        public int SchedulerStartTime { get; set; }
        public string RccpSchema { get; set; }
        public string AuditSchema { get; set; }
    }
}
