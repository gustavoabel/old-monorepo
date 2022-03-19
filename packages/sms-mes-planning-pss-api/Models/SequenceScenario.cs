namespace sms_mes_planning_pss_api.Models
{
    public class SequenceScenario
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Remark { get; set; }
        public int Rating { get; set; }
        public int GroupSequenceId { get; set; }
        public string GroupSequenceName { get; set; }
        public bool Selected { get; set; }
        public bool Deleted { get; set; }
        public bool? IsOptimized { get; set; }        
        public int? MaterialFilterId { get; set; }
        public int? PlanningHorizonId { get; set; }                
        public int RuleViolation { get; set; }
        public int Materials { get; set; }
        public string MaterialFilterName { get; set; }
        public bool UseOptimizer { get; set; }   
    }
}
