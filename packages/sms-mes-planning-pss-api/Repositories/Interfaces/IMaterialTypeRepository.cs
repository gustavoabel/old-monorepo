using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IMaterialTypeRepository
    {
        IEnumerable<MaterialType> GetByProductionUnitId(int productionUnitId);
    }
}
