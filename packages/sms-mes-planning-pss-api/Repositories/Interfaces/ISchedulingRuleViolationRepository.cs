using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface ISchedulingRuleViolationRepository
    {
        bool CheckViolationByScenarioId(int sequenceScenarioId);
        IEnumerable<SchedulingRuleViolation> GetComboBySequenceItem(int MaterialId, int SequenceItemId);
        bool AcceptRuleViolation(SchedulingRuleViolationAcceptance RuleViolationAccept);
        IEnumerable<MaterialRuleViolation> GetViolationForMaterial(int SequenceItemId, string Position);
    }
}
