using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class PlanningHorizonRepository : IPlanningHorizonRepository
    {
        private readonly IBaseRepository _baseRepository;

        public PlanningHorizonRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<PlanningHorizon> GetAll()
        {
            return _baseRepository.GetQueryResult<PlanningHorizon>(PlanningHorizonQuery.GetAll);
        }

        public IEnumerable<PlanningHorizon> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<PlanningHorizon>(PlanningHorizonQuery.GetByProductionUnitGroupId, parameters);
        }

        public void Add(PlanningHorizon planningHorizon)
        {
            var parameters = new
            {
                horizon = planningHorizon.Horizon,
                name = planningHorizon.Name,
                description = planningHorizon.Description,
                is_default = planningHorizon.IsDefault,
                production_unit_group_id = planningHorizon.ProductionUnitGroupId,
                material_attribute_definition_id = planningHorizon.MaterialAttributeDefinitionId,
            };
            _baseRepository.RunQuery(PlanningHorizonQuery.Add, parameters);
        }

        public PlanningHorizon GetDefaultPlanningHorizon(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<PlanningHorizon>(PlanningHorizonQuery.GetDefault, parameters).FirstOrDefault();
        }

        public void Update(PlanningHorizon planningHorizon)
        {
            var parameters = new
            {
                id = planningHorizon.Id,
                horizon = planningHorizon.Horizon,
                name = planningHorizon.Name,
                description = planningHorizon.Description,
                is_default = planningHorizon.IsDefault,
                material_attribute_definition_id = planningHorizon.MaterialAttributeDefinitionId,
            };
            _baseRepository.RunQuery(PlanningHorizonQuery.Update, parameters);
        }

        public void Delete(int planningHorizonId)
        {
            var parameters = new
            {
                id = planningHorizonId
            };
            _baseRepository.RunQuery(PlanningHorizonQuery.Delete, parameters);
        }

        public PlanningHorizon GetById(int planningHorizonId)
        {
            var parameters = new
            {
                id = planningHorizonId
            };
            return _baseRepository.GetQueryResult<PlanningHorizon>(PlanningHorizonQuery.GetById, parameters).FirstOrDefault();
        }
    }
}
