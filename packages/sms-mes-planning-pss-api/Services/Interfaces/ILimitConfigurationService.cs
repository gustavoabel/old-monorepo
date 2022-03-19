using System.Collections.Generic;
using sms_mes_planning_pss_api.Models;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
  public interface ILimitConfigurationService
  {
    IEnumerable<LimitConfiguration> GetAll();
    
    void Update(LimitConfiguration limitConfiguration);
  }
}