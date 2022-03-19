using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;
using System.Dynamic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IUnitSequenceRepository
    {
        int Add(UnitSequence unitSequence);
        UnitSequence GetById(int unitSequenceId);
        IEnumerable<UnitSequence> GetBySequenceScenarioId(int sequenceScenarioId);
        IEnumerable<UnitSequence> GetCastersBySequenceScenarioId(int sequenceScenarioId);
        UnitSequence GetHSMUnitSequenceByCaster(int CasterUnitSequence);
        IEnumerable<MaterialHeat> GetHeatListByUnitSequence(int unitSequenceId);
        int GetNewSequenceItemOrder(int unitSequenceId);
        int GetNewOutputOrder(int sequenceItemId);
        int GetLastSequenceItemOrder(int unitSequenceId);
        HSMItemWithCasterUnit GetLastItemOfCaster(int hsmUnitSequenceId, int casterUnitSequenceId);
        HSMItemWithCasterUnit GetLastItemOfDifferentCaster(int hsmUnitSequenceId, int casterUnitSequenceId);
        bool AddNewInputMaterial(int sequenceItemId, int materialId, int materialOrder);
        bool AddNewMaterial(int sequenceItemId, int materialId, int materialOrder);
        IEnumerable<dynamic> GetCasterMaterialList(int unitSequenceId);
        IEnumerable<dynamic> GetHSMMaterialList(int unitSequenceId);
        List<ExpandoObject> GetInputMaterialList(int unitSequenceId);
        List<ExpandoObject> GetOutputMaterialList(int unitSequenceId);
        UnitSequenceAttributesSum GetSumOfAttributes(string unitSequenceName, int scenarioId);
    }
}
