using System.Collections.Generic;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class LimitConfigurationRepository : ILimitConfigurationRepository
    {
        private readonly IBaseRepository _baseRepository;

        public LimitConfigurationRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }
        public IEnumerable<LimitConfiguration> GetAll()
        {
            return _baseRepository.GetQueryResult<LimitConfiguration>(LimitConfigurationQuery.GetAll);
        }
        public void Update(LimitConfiguration limitConfiguration)
        {
            var parameters = new
            {
                id = limitConfiguration.Id,
                min_heat_weight = limitConfiguration.MinHeatWeight,
                max_heat_weight = limitConfiguration.MaxHeatWeight,
                min_sequence_size = limitConfiguration.MinSequenceSize,
                max_sequence_size = limitConfiguration.MaxSequenceSize
            };
            _baseRepository.RunQuery(LimitConfigurationQuery.Update, parameters);
        }
    }
}