using System.Collections.Generic;
using Microsoft.AspNetCore.Http;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;

namespace sms_mes_planning_pss_api.Services
{
    public class LimitConfigurationService : ILimitConfigurationService
    {
        private readonly ILimitConfigurationRepository _limitConfigurationRepository;

        public LimitConfigurationService(ILimitConfigurationRepository limitConfigurationRepository)
        {
            _limitConfigurationRepository = limitConfigurationRepository;
        }

        public IEnumerable<LimitConfiguration> GetAll()
        {
            return _limitConfigurationRepository.GetAll();
        }
        public void Update(LimitConfiguration limitConfiguration)
        {
            ValidateLimitConfiguration(limitConfiguration);
            _limitConfigurationRepository.Update(limitConfiguration);
        }

        private void ValidateLimitConfiguration(LimitConfiguration limitConfiguration)
        {
            if (!AllLimitsArePositive(limitConfiguration))
                throw new BadHttpRequestException("All limits should be positive");

            if (!IsLimitConfigurationValid(limitConfiguration))
                throw new BadHttpRequestException("Ranges should be valid");
        }

        private bool AllLimitsArePositive(LimitConfiguration limitConfiguration)
        {
            return limitConfiguration.MinHeatWeight >= 0
              && limitConfiguration.MaxHeatWeight >= 0
              && limitConfiguration.MinSequenceSize >= 0
              && limitConfiguration.MaxSequenceSize >= 0;
        }

        private bool IsLimitConfigurationValid(LimitConfiguration limitConfiguration)
        {
            return limitConfiguration.MinHeatWeight <= limitConfiguration.MaxHeatWeight
            && limitConfiguration.MinSequenceSize <= limitConfiguration.MaxSequenceSize;
        }
    }
}