using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IPlanningHorizonService
    {
        IEnumerable<PlanningHorizon> GetAll();
        IEnumerable<PlanningHorizon> GetByProductionUnitGroupId(int productionUnitGroupId);

        void Add(PlanningHorizon planningHorizon);

        void Update(PlanningHorizon planningHorizon);

        void Delete(int planningHorizonId);

        string ConvertToQuery(int planningHorizonId);
    }
}
