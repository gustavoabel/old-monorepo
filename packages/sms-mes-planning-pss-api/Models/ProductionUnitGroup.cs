namespace sms_mes_planning_pss_api.Models
{
    public class ProductionUnitGroup
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool HasPredecessor { get; set; }
        public bool HasSuccessor { get; set; }
        public string Layout { get; set; }
    }
}
