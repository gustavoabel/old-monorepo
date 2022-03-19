namespace sms_mes_planning_pss_api.Models
{
    public class SchedulingRuleViolation
    {
        public int Id { get; set; }
        public string Implementation { get; set; }
        public string Name { get; set; }
    }

    public class SchedulingRuleViolationAcceptance
    {
        public int SchedulingRuleViolationId { get; set; }
        public string Responsible { get; set; }
    }

    public class MaterialRuleViolation
    {
        public int RuleViolationId { get; set; }
        public int MaterialAttributeDefinitionId { get; set; }
        public string MaterialAttributeDefinitionName { get; set; }
        public int SequenceItemId { get; set; }
        public string RuleViolationPositionFrom { get; set; }
        public string RuleViolationPositionTo { get; set; }
    }
}
