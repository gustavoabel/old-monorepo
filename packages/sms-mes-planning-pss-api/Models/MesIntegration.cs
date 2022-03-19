using System;

namespace sms_mes_planning_pss_api.Models
{
    public class MesIntegration
    {
        public int Id { get; set; }
        public string IntegrationType { get; set; }
        public Nullable<DateTime> LastIntegration { get; set; }
    }
}
