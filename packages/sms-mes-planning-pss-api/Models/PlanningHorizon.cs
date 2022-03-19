namespace sms_mes_planning_pss_api.Models
{
  public class PlanningHorizon
  {
    public int Id { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public int Horizon { get; set; }
    public bool IsDefault { get; set; }
    public int ProductionUnitGroupId { get; set; }
    public int MaterialAttributeDefinitionId { get; set; }
  }

  public class PlanningHorizonForQuery
  {
    public string AttributeName { get; set; }
    public int Horizon { get; set; }
  }
}
