using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IMaterialAttributeDefinitionRepository
    {
        IEnumerable<MaterialAttributeDefinition> GetPlanningHorizonOptions(int productionUnitGroupId);
        IEnumerable<MaterialAttributeDefinition> GetMaterialFilterOptions(int productionUnitGroupId);
        IEnumerable<MaterialAttributeDefinition> GetByMaterialType(int materialTypeId);
        IEnumerable<MaterialAttributeDefinition> GetByProductionUnitId(int productionUnit);
        MaterialAttributeDefinition GetByMaterialTypeAndAttributeName(string materialAttributeDefinitionName, string materialTypeName);
        IEnumerable<MaterialAttributeDefinition> GetAddMaterialAttributes(int productionUnitId);
        string GetCustomColumnOrder(string tableType, string userId);
        void SetCustomColumnOrder(string tableType, string userId, string columnOrder);
        void UpdateCustomColumnOrder(string tableType, string userId, string columnOrder);
    }
}
