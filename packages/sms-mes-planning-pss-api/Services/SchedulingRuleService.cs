using Microsoft.AspNetCore.Http;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;
using System.Linq;

namespace sms_mes_planning_pss_api.Services
{
    public class SchedulingRuleService : ISchedulingRuleService
    {
        private readonly ISchedulingRuleRepository _schedulingRuleRepository;
        private readonly IMaterialAttributeDefinitionService _materialAttributeDefinitionService;

        public SchedulingRuleService(ISchedulingRuleRepository schedulingRuleRepository,
            IMaterialAttributeDefinitionService materialAttributeDefinitionService)
        {
            _schedulingRuleRepository = schedulingRuleRepository;
            _materialAttributeDefinitionService = materialAttributeDefinitionService;
        }

        public int Add(SchedulingRule schedulingRule)
        {
            ValidateSchedulingRule(schedulingRule);
            return _schedulingRuleRepository.Add(schedulingRule);
        }

        public void Delete(int id)
        {
            _schedulingRuleRepository.Delete(id);
        }

        public IEnumerable<SchedulingRule> GetAll()
        {
            return _schedulingRuleRepository.GetAll();
        }

        public void Update(SchedulingRule schedulingRule)
        {
            ValidateSchedulingRule(schedulingRule);
            _schedulingRuleRepository.Update(schedulingRule);
        }

        private void ValidateSchedulingRule(SchedulingRule schedulingRule)
        {
            if (!IsSchedulingRuleValid(schedulingRule))
                throw new BadHttpRequestException("Please fill all the mandatory fields");

            if (!IsAttributeFromProductionUnit(schedulingRule))
                throw new BadHttpRequestException("Please choose a material attribute from the chosen production unit");
        }

        private bool IsSchedulingRuleValid(SchedulingRule schedulingRule)
        {
            return !string.IsNullOrEmpty(schedulingRule.Name)
                && !string.IsNullOrEmpty(schedulingRule.Implementation);
        }

        private bool IsAttributeFromProductionUnit(SchedulingRule schedulingRule)
        {
            var materialAttributeDefinitionList = _materialAttributeDefinitionService.GetByProductionUnitId(schedulingRule.ProductionUnitId);
            return materialAttributeDefinitionList.Any(m => m.Id == schedulingRule.MaterialAttributeDefinitionId);
        }
    }
}
