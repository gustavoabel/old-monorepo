using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IMaterialFilterService
    {
        IEnumerable<MaterialFilter> GetAll();

        IEnumerable<MaterialFilter> GetByProductionUnitGroupId(int productionUnitGroupId);

        void Add(MaterialFilter materialFilter);

        void Update(MaterialFilter materialFilter);

        void Delete(int materialFilterId);

        IEnumerable<dynamic> GetFilteredMaterialsList(int materialFilterId, IEnumerable<dynamic> materialsList);
    }
}
