namespace sms_mes_planning_pss_api.Models
{
  public class LimitConfiguration
  {
    public int Id { get; set; }
    public int MinHeatWeight { get; set; }
    public int MaxHeatWeight { get; set; }
    public int MinSequenceSize { get; set; }
    public int MaxSequenceSize { get; set; }
    public int ProductionUnitId { get; set; }
    public string Name { get; set; }
  }
}