using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IMaterialAttributeDefinitionService
    {
        IEnumerable<MaterialAttributeDefinition> GetPlanningHorizonOptions(int productionUnitGroupId);
        IEnumerable<MaterialAttributeDefinition> GetMaterialFilterOptions(int productionUnitGroupId);
        IEnumerable<MaterialAttributeDefinition> GetByMaterialType(int materialTypeId);
        IEnumerable<MaterialAttributeDefinition> GetByProductionUnitId(int productionUnit);
        IEnumerable<MaterialAttributeDefinition> GetAddMaterialAttributes(int productionUnitId);
        string GetCustomColumnOrder(string tableType, string userId);
        bool SetCustomColumnOrder(string tableType, string userId, string columnOrder);
    }
}
