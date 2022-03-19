using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services
{
    public class SchedulingRuleViolationService : ISchedulingRuleViolationService
    {
        private readonly ISchedulingRuleViolationRepository _schedulingRuleViolationRepository;        

        public SchedulingRuleViolationService(
            ISchedulingRuleViolationRepository schedulingRuleViolationRepository
        )
        {
            _schedulingRuleViolationRepository = schedulingRuleViolationRepository;            
        }

        public bool CheckViolationByScenarioId(int scenarioId)
        {
            return _schedulingRuleViolationRepository.CheckViolationByScenarioId(scenarioId);
        }

        public IEnumerable<SchedulingRuleViolation> GetComboBySequenceItem(int MaterialId, int SequenceItemId)
        {
            try
            {
                return _schedulingRuleViolationRepository.GetComboBySequenceItem(MaterialId, SequenceItemId);
            }
            catch (System.Exception)
            {
                
                return default(IEnumerable<SchedulingRuleViolation>);
            }
        }

        public bool AcceptRuleViolation(SchedulingRuleViolationAcceptance RuleViolationAccept)
        {
            bool isAccepted = _schedulingRuleViolationRepository.AcceptRuleViolation(RuleViolationAccept);

            if (isAccepted) {
                return true;
            }

            return false; 
        }
    }
}
