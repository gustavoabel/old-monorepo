namespace sms_mes_planning_pss_api.Models
{
    public class SchedulingRule
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Remark { get; set; }
        public string Implementation { get; set; }
        public string ImplementationTranspiled { get; set; }
        public int MaterialTypeId { get; set; }
        public int MaterialAttributeDefinitionId { get; set; }
        public int ProductionUnitId { get; set; }
    }
}
