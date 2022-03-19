using sms_mes_planning_pss_api.Models;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface ISequenceScenarioVersionRepository
    {
        int Add(SequenceScenarioVersion sequenceScenarioVersion);
    }
}
