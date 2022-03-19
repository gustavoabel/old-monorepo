using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories
{
    public class KPIRepository : IKPIRepository
    {
        private readonly IBaseRepository _baseRepository;

        public KPIRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<MaterialKPI> GetBySequenceScenarioId(int sequenceScenarioId)
        {
            var parameters = new
            {
                sequenceScenarioId
            };

            return _baseRepository.GetQueryResult<MaterialKPI>(KPIQuery.GetBySequenceScenarioId, parameters);
        }
    }
}
