using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IPlanningHorizonRepository
    {
        IEnumerable<PlanningHorizon> GetAll();
        IEnumerable<PlanningHorizon> GetByProductionUnitGroupId(int productionUnitGroupId);

        void Add(PlanningHorizon planningHorizon);

        void Update(PlanningHorizon planningHorizon);

        void Delete(int planningHorizonId);

        PlanningHorizon GetDefaultPlanningHorizon(int productionUnitGroupId);

        PlanningHorizon GetById(int planningHorizonId);
    }
}
