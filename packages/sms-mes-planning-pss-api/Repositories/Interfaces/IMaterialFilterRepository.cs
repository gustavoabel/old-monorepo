using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IMaterialFilterRepository
    {
        IEnumerable<MaterialFilter> GetAll();

        IEnumerable<MaterialFilter> GetByProductionUnitGroupId(int productionUnitGroupId);

        void Add(MaterialFilter materialFilter);

        MaterialFilter GetDefaultMaterialFilter(int productionUnitGroupId);

        void Update(MaterialFilter materialFilter);

        void Delete(int materialFilterId);

        MaterialFilter GetById(int materialFilterId);

        bool hasScenarios(int materialFilterId);
    }
}
