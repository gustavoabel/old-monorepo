using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using sms_mes_planning_pss_api.Services.Interfaces;
using sms_mes_planning_pss_api.Utils;
using System.Collections.Generic;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class SchedulingRuleRepository : ISchedulingRuleRepository
    {
        private readonly IBaseRepository _baseRepository;

        public SchedulingRuleRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }
        public int Add(SchedulingRule schedulingRule)
        {
            string javascriptSource = TranspileUtil.CreateAndTranspile(schedulingRule.Implementation);

            var parameters = new
            {
                name = schedulingRule.Name,
                remark = schedulingRule.Remark,
                implementation = schedulingRule.Implementation,
                implementation_transpiled = javascriptSource,
                material_attribute_definition_id = schedulingRule.MaterialAttributeDefinitionId,
                production_unit_id = schedulingRule.ProductionUnitId
            };

            return _baseRepository.GetQueryResult<int>(SchedulingRuleQuery.Add, parameters).FirstOrDefault();
        }

        public void Delete(int id)
        {
            var parameters = new
            {
                id,
            };
            _baseRepository.RunQuery(SchedulingRuleQuery.Delete, parameters);
        }

        public IEnumerable<SchedulingRule> GetAll()
        {
            return _baseRepository.GetQueryResult<SchedulingRule>(SchedulingRuleQuery.GetAll);
        }

        public void Update(SchedulingRule schedulingRule)
        {
            string javascriptSource = TranspileUtil.CreateAndTranspile(schedulingRule.Implementation);
            
            var parameters = new
            {
                id = schedulingRule.Id,
                name = schedulingRule.Name,
                remark = schedulingRule.Remark,
                implementation = schedulingRule.Implementation,
                implementation_transpiled = javascriptSource,
                material_attribute_definition_id = schedulingRule.MaterialAttributeDefinitionId,
                production_unit_id = schedulingRule.ProductionUnitId
            };
            _baseRepository.RunQuery(SchedulingRuleQuery.Update, parameters);
        }
    }
}
