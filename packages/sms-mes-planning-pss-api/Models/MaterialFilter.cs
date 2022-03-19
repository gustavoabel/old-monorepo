namespace sms_mes_planning_pss_api.Models
{
    public class MaterialFilter
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Expression { get; set; }
        public bool IsDefault { get; set; }
        public int ProductionUnitGroupId { get; set; }
    }
}
