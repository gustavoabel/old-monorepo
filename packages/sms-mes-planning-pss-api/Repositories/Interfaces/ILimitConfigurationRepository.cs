using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
  public interface ILimitConfigurationRepository
  {
    IEnumerable<LimitConfiguration> GetAll();
    void Update(LimitConfiguration limitConfiguration);
  }
}
