using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IGroupSequenceService
    {
        int Add(GroupSequence groupSequence);
        void Update(GroupSequence groupSequence);
        IEnumerable<GroupSequence> GetAll();
        void Delete(int groupSequenceId);
        GroupSequence GetById(int groupSequenceId);
        GroupSequence GetSequenceByScenarioId(int scenarioId);
        bool BookGroupSequence(int groupSequenceId, int sequenceScenarioId);
        bool SaveSequencesMes(int groupSequenceId);
    }
}
