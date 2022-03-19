using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface ISequenceScenarioService
    {
        int Add(SequenceScenario sequenceScenario);
        IEnumerable<SequenceScenario> GetByGroupSequenceId(int? groupSequenceId);
        void Delete(int id);
        void Update(SequenceScenario sequenceScenario);
        dynamic GetMaterialList(int sequenceScenarioId);
    }
}
