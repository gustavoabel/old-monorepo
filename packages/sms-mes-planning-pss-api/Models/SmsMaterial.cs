using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Models
{
  public class Materials
  {
    public IEnumerable<dynamic> Coils { get; set; }
    public IEnumerable<dynamic> Slabs { get; set; }
  }
}