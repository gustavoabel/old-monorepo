using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;
using System;

namespace sms_mes_planning_pss_api.Services
{
    public class MaterialAttributeDefinitionService : IMaterialAttributeDefinitionService
    {
        private readonly IMaterialAttributeDefinitionRepository _materialAttributeDefinitionRepository;

        public MaterialAttributeDefinitionService(IMaterialAttributeDefinitionRepository materialAttributeDefinitionRepository)
        {
            _materialAttributeDefinitionRepository = materialAttributeDefinitionRepository;
        }

        public IEnumerable<MaterialAttributeDefinition> GetMaterialFilterOptions(int productionUnitGroupId)
        {
            return _materialAttributeDefinitionRepository.GetMaterialFilterOptions(productionUnitGroupId);
        }

        public IEnumerable<MaterialAttributeDefinition> GetPlanningHorizonOptions(int productionUnitGroupId)
        {
            return _materialAttributeDefinitionRepository.GetPlanningHorizonOptions(productionUnitGroupId);
        }

        public IEnumerable<MaterialAttributeDefinition> GetByMaterialType(int materialTypeId)
        {
            return _materialAttributeDefinitionRepository.GetByMaterialType(materialTypeId);
        }

        public IEnumerable<MaterialAttributeDefinition> GetByProductionUnitId(int productionUnit)
        {
            return _materialAttributeDefinitionRepository.GetByProductionUnitId(productionUnit);
        }

        public IEnumerable<MaterialAttributeDefinition> GetAddMaterialAttributes(int productionUnitId)
        {
            return _materialAttributeDefinitionRepository.GetAddMaterialAttributes(productionUnitId);
        }

        public string GetCustomColumnOrder(string tableType, string userId)
        {
            return _materialAttributeDefinitionRepository.GetCustomColumnOrder(tableType, userId);
        }

        public bool SetCustomColumnOrder(string tableType, string userId, string columnOrder)
        {
            try
            {
                string hasCustomColumnOrder = _materialAttributeDefinitionRepository.GetCustomColumnOrder(tableType, userId);

                if (hasCustomColumnOrder != "")
                {
                    _materialAttributeDefinitionRepository.UpdateCustomColumnOrder(tableType, userId, columnOrder);
                }
                else
                {
                    _materialAttributeDefinitionRepository.SetCustomColumnOrder(tableType, userId, columnOrder);
                }

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                return false;
            }

        }
    }
}
