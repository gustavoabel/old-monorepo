using Microsoft.AspNetCore.Http;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services
{
    public class PlanningHorizonService : IPlanningHorizonService
    {
        private readonly IPlanningHorizonRepository _planningHorizonRepository;

        public PlanningHorizonService(IPlanningHorizonRepository planningHorizonRepository)
        {
            _planningHorizonRepository = planningHorizonRepository;
        }

        public void Add(PlanningHorizon planningHorizon)
        {
            ValidatePlanningHorizon(planningHorizon);

            PlanningHorizon defaultPlanningHorizon = GetDefaultPlanningHorizon(planningHorizon.ProductionUnitGroupId);
            if (defaultPlanningHorizon != null)
                UpdateOldDefaultPlanningHorizon(planningHorizon, defaultPlanningHorizon);
            else
                planningHorizon.IsDefault = true;

            _planningHorizonRepository.Add(planningHorizon);
        }

        public void Update(PlanningHorizon planningHorizon)
        {
            PlanningHorizon defaultPlanningHorizon = GetDefaultPlanningHorizon(planningHorizon.ProductionUnitGroupId);
            if (defaultPlanningHorizon != null)
            {
                ValidateUpdatePlanningHorizon(planningHorizon, defaultPlanningHorizon);
                UpdateOldDefaultPlanningHorizon(planningHorizon, defaultPlanningHorizon);
            }
            else
            {
                ValidatePlanningHorizon(planningHorizon);
                planningHorizon.IsDefault = true;
            }
            _planningHorizonRepository.Update(planningHorizon);
        }

        public void Delete(int planningHorizonId)
        {
            ValidateDeletePlanningHorizon(planningHorizonId);
            _planningHorizonRepository.Delete(planningHorizonId);
        }

        public IEnumerable<PlanningHorizon> GetAll()
        {
            return _planningHorizonRepository.GetAll();
        }

        public IEnumerable<PlanningHorizon> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            return _planningHorizonRepository.GetByProductionUnitGroupId(productionUnitGroupId);
        }

        public string ConvertToQuery(int planningHorizonId)
        {
            var ph = _planningHorizonRepository.GetById(planningHorizonId);
            string DateFilter = "";

            if (ph.Horizon < 0)
            {
                DateFilter = $@"to_date(ma.value,'YYYY-MM-DD') between (current_date {ph.Horizon}) and current_date";
            } else if (ph.Horizon > 0)
            {
                DateFilter = $@"to_date(ma.value,'YYYY-MM-DD') between current_date and (current_date + {ph.Horizon})";
            } else {
                DateFilter = $@"to_date(ma.value,'YYYY-MM-DD') = current_date";
            }

            var query = $@"and 
                m.id in (
                    select m.id 
                    from 
                        pss.material m 
                        inner join pss.material_attribute ma 
                            on m.id = ma.material_id 
                    where 
                        ma.material_attribute_definition_id = {ph.MaterialAttributeDefinitionId} and
                        {DateFilter}
                )
            ";

            return query;
        }

        private PlanningHorizon GetDefaultPlanningHorizon(int productionUnitGroupId)
        {
            return _planningHorizonRepository.GetDefaultPlanningHorizon(productionUnitGroupId);
        }

        private void ValidateUpdatePlanningHorizon(PlanningHorizon planningHorizon, PlanningHorizon defaultPlanningHorizon)
        {
            ValidatePlanningHorizon(planningHorizon);

            if (IsDefaultUpdateSetToFalse(planningHorizon, defaultPlanningHorizon))
                throw new BadHttpRequestException("You can't set a default planning horizon to a non default value");
        }

        private void ValidatePlanningHorizon(PlanningHorizon planningHorizon)
        {
            if (!IsPlanningHorizonValid(planningHorizon))
                throw new BadHttpRequestException("Please fill all the mandatory fields");
        }

        private void UpdateOldDefaultPlanningHorizon(PlanningHorizon planningHorizon, PlanningHorizon defaultPlanningHorizon)
        {
            if (planningHorizon.IsDefault && defaultPlanningHorizon.Id != planningHorizon.Id)
            {
                defaultPlanningHorizon.IsDefault = false;
                _planningHorizonRepository.Update(defaultPlanningHorizon);
            }
        }

        private bool IsDefaultUpdateSetToFalse(PlanningHorizon planningHorizon, PlanningHorizon defaultPlanningHorizon)
        {
            return defaultPlanningHorizon != null && !planningHorizon.IsDefault && defaultPlanningHorizon.IsDefault && planningHorizon.Id == defaultPlanningHorizon.Id;
        }

        private void ValidateDeletePlanningHorizon(int planningHorizonId)
        {
            PlanningHorizon planningHorizon = GetById(planningHorizonId);
            if (planningHorizon.IsDefault)
                throw new BadHttpRequestException("You can't delete a default planning horizon");
        }

        private PlanningHorizon GetById(int planningHorizonId)
        {
            return _planningHorizonRepository.GetById(planningHorizonId);
        }

        private bool IsPlanningHorizonValid(PlanningHorizon planningHorizon)
        {
            return !string.IsNullOrEmpty(planningHorizon.Name);
        }

    }
}
