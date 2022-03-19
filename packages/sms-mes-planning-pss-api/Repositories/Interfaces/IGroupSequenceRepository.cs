using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IGroupSequenceRepository
    {
        int Add(GroupSequence groupSequence);
        void Update(GroupSequence groupSequence);
        IEnumerable<GroupSequence> GetAll();
        void Delete(int groupSequenceId);
        GroupSequence GetById(int groupSequenceId);
        GroupSequence GetSequenceByScenarioId(int scenarioId);
        bool ChangePlanningStatus(int groupSequenceId, string planningStatus);
        SendToMES GetMesProgram(int GroupSequenceId, int SequenceScenarioVersionId, int ProductionUnitId);
        int GetDurationProgramLine(int GroupSequenceId, int SequenceScenarioVersionId, int ProductionUnitId);        
    }
}
