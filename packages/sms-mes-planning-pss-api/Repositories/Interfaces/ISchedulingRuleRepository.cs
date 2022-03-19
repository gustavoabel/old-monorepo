using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface ISchedulingRuleRepository
    {
        IEnumerable<SchedulingRule> GetAll();
        void Update(SchedulingRule schedulingRule);
        void Delete(int id);
        int Add(SchedulingRule schedulingRule);
    }
}
