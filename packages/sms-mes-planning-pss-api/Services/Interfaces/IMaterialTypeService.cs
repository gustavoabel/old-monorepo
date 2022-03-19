using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IMaterialTypeService
    {
        IEnumerable<MaterialType> GetByProductionUnitId(int productionUnitId);
    }
}
