using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IUnitSequenceService
    {
        int Add(UnitSequence unitSequence);
        IEnumerable<UnitSequence> GetBySequenceScenarioId(int sequenceScenarioId);
        IEnumerable<UnitSequence> GetCastersBySequenceScenarioId(int sequenceScenarioId);
        IEnumerable<MaterialHeat> GetHeatListByUnitSequence(int unitSequenceId);
        int GetNewOutputOrder(int sequenceItemId);
        bool AddNewMaterial(UnitSequenceNewMaterial[] unitSequenceNewMaterial);
        int AddNewSequenceItem(int unitSequenceId, int? heatGroupId);
        int AddNewHSMSequenceItemWithPosition(int unitSequenceId, int order);
        IEnumerable<dynamic> GetCasterMaterialList(int unitSequenceId);
        IEnumerable<dynamic> GetHSMMaterialList(int unitSequenceId);
        UnitSequenceAttributesSum GetSumOfAttributes(string unitSequenceName, int scenarioId);
    }
}
