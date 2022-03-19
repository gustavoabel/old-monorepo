using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface ISequenceScenarioRepository
    {
        SequenceScenario GetByUnitSequenceId(int UnitSequenceId);
        int Add(SequenceScenario sequenceScenario);
        IEnumerable<SequenceScenario> GetByGroupSequenceId(int? groupSequenceId);
        SequenceScenario GetBySequenceItemId(int sequenceItemId);
        void Delete(int id);
        SequenceScenario GetDuplicate(SequenceScenario sequenceScenario);
        void Update(SequenceScenario sequenceScenario);
        int GetSelectedSequenceScenario(int GroupSequenceId);
        bool SelectActualSequenceScenario(int sequenceScenarioId, int groupSequenceId);
        IEnumerable<SequenceScenario> GetPedingOptimizedSequences();
        void ChangeOptimizedScenario(int SequenceScenarioId, int GroupSequenceId, int? MaterialFilterId, int? PlanningHorizonId);
    }
}
