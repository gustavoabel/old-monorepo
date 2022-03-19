using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class SequenceScenarioVersionRepository : ISequenceScenarioVersionRepository
    {
        private readonly IBaseRepository _baseRepository;

        public SequenceScenarioVersionRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public int Add(SequenceScenarioVersion sequenceScenarioVersion)
        {
            var parameters = new
            {
                name = sequenceScenarioVersion.Name,
                remark = sequenceScenarioVersion.Remark,
                sequence_scenario_id = sequenceScenarioVersion.SequenceScenarioId
            };
            return _baseRepository.GetQueryResult<int>(SequenceScenarioVersionQuery.Add, parameters).FirstOrDefault();
        }
    }
}
