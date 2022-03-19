using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;
using System.Linq;
using System;
using Newtonsoft.Json;

namespace sms_mes_planning_pss_api.Repositories
{
    public class MaterialAttributeDefinitionRepository : IMaterialAttributeDefinitionRepository
    {
        private readonly IBaseRepository _baseRepository;

        public MaterialAttributeDefinitionRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<MaterialAttributeDefinition> GetPlanningHorizonOptions(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetPlanningHorizonOptions, parameters);
        }
        public IEnumerable<MaterialAttributeDefinition> GetMaterialFilterOptions(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            string where = "and lower(mt.name) not like '%heat%'";

            return _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetByProductionUnitGroupId(where), parameters);
        }
        public IEnumerable<MaterialAttributeDefinition> GetByMaterialType(int materialTypeId)
        {
            var parameters = new
            {
                materialTypeId
            };
            return _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetByMaterialType, parameters);
        }
        public IEnumerable<MaterialAttributeDefinition> GetByProductionUnitId(int productionUnitId)
        {
            var parameters = new
            {
                productionUnitId
            };
            return _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetByProductionUnitId, parameters);
        }
        public MaterialAttributeDefinition GetByMaterialTypeAndAttributeName(string materialAttributeDefinitionName, string materialTypeName)
        {
            var parameters = new
            {
                materialAttributeDefinitionName,
                materialTypeName
            };

            return _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetByMaterialTypeAndAttributeName, parameters).SingleOrDefault();
        }
        public IEnumerable<MaterialAttributeDefinition> GetAddMaterialAttributes(int productionUnitId)
        {
            var parameters = new
            {
                productionUnitId
            };
            return _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetAddMaterialAttributes, parameters);
        }

        public string GetCustomColumnOrder(string tableType, string userId)
        {
            var parameters = new
            {
                tableType,
                userId
            };

            string customColumnOrder = _baseRepository.GetQueryResult<string>(MaterialAttributeDefinitionQuery.GetCustomColumnOrder, parameters).FirstOrDefault();

            if (customColumnOrder != null)
            {
                var jsonReturn = JsonConvert.DeserializeObject<CustomColumn[]>(customColumnOrder);

                for (int i = 0; i < jsonReturn.Length; ++i)
                {
                    if (Int32.Parse(jsonReturn[i].Field) == 0)
                    {
                        jsonReturn[i].Title = "TYPE";
                    }
                    else
                    {
                        var jsonParameters = new
                        {
                            field = Int32.Parse(jsonReturn[i].Field)
                        };

                        jsonReturn[i].Title = _baseRepository.GetQueryResult<string>(MaterialAttributeDefinitionQuery.GetTitleByField,
                        jsonParameters).FirstOrDefault().Replace("_", " ");
                    }
                }

                return JsonConvert.SerializeObject(jsonReturn);

            }
            
            return "";

        }

        public void SetCustomColumnOrder(string tableType, string userId, string columnOrder)
        {
            var parameters = new
            {
                tableType,
                userId,
                columnOrder
            };

            _baseRepository.RunQuery(MaterialAttributeDefinitionQuery.SetCustomColumnOrder, parameters);
        }

        public void UpdateCustomColumnOrder(string tableType, string userId, string columnOrder)
        {
            var parameters = new
            {
                tableType,
                userId,
                columnOrder
            };

            _baseRepository.RunQuery(MaterialAttributeDefinitionQuery.UpdateCustomColumnOrder, parameters);
        }
    }
}
