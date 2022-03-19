using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface ISchedulingRuleViolationService
    {        
        bool CheckViolationByScenarioId(int scenarioId);
        IEnumerable<SchedulingRuleViolation> GetComboBySequenceItem( int MaterialId, int SequenceItemId);
        bool AcceptRuleViolation(SchedulingRuleViolationAcceptance RuleViolationAccept);
    }
}
