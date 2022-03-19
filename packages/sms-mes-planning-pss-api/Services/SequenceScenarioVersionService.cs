using Microsoft.AspNetCore.Http;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;

namespace sms_mes_planning_pss_api.Services
{
    public class SequenceScenarioVersionService : ISequenceScenarioVersionService
    {
        private readonly ISequenceScenarioVersionRepository _sequenceScenarioVersionRepository;

        public SequenceScenarioVersionService(ISequenceScenarioVersionRepository sequenceScenarioVersionRepository)
        {
            _sequenceScenarioVersionRepository = sequenceScenarioVersionRepository;
        }

        public int Add(SequenceScenarioVersion sequenceScenarioVersion)
        {
            ValidateSequenceScenarioVersion(sequenceScenarioVersion);
            return _sequenceScenarioVersionRepository.Add(sequenceScenarioVersion);
        }

        private void ValidateSequenceScenarioVersion(SequenceScenarioVersion sequenceScenarioVersion)
        {
            if (!IsSequenceScenarioVersionValid(sequenceScenarioVersion))
                throw new BadHttpRequestException("please fill all the mandatory fields");
        }

        private bool IsSequenceScenarioVersionValid(SequenceScenarioVersion sequenceScenarioVersion)
        {
            return !string.IsNullOrEmpty(sequenceScenarioVersion.Name);
        }
    }
}
