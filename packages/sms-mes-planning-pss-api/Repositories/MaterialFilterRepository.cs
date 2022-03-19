using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class MaterialFilterRepository : IMaterialFilterRepository
    {
        private readonly IBaseRepository _baseRepository;

        public MaterialFilterRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<MaterialFilter> GetAll()
        {
            return _baseRepository.GetQueryResult<MaterialFilter>(MaterialFilterQuery.GetAll);
        }

        public IEnumerable<MaterialFilter> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<MaterialFilter>(MaterialFilterQuery.GetByProductionUnitGroupId, parameters);
        }

        public void Add(MaterialFilter materialFilter)
        {
            var parameters = new
            {
                name = materialFilter.Name,
                description = materialFilter.Description,
                expression = materialFilter.Expression,
                is_default = materialFilter.IsDefault,
                production_unit_group_id = materialFilter.ProductionUnitGroupId
            };
            _baseRepository.RunQuery(MaterialFilterQuery.Add, parameters);
        }

        public MaterialFilter GetDefaultMaterialFilter(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<MaterialFilter>(MaterialFilterQuery.GetDefault, parameters).FirstOrDefault();
        }

        public void Update(MaterialFilter materialFilter)
        {
            var parameters = new
            {
                id = materialFilter.Id,
                name = materialFilter.Name,
                description = materialFilter.Description,
                expression = materialFilter.Expression,
                is_default = materialFilter.IsDefault
            };
            _baseRepository.RunQuery(MaterialFilterQuery.Update, parameters);
        }

        public void Delete(int materialFilterId)
        {
            var parameters = new
            {
                id = materialFilterId
            };
            _baseRepository.RunQuery(MaterialFilterQuery.Delete, parameters);
        }

        public MaterialFilter GetById(int materialFilterId)
        {
            var parameters = new
            {
                id = materialFilterId
            };
            return _baseRepository.GetQueryResult<MaterialFilter>(MaterialFilterQuery.GetById, parameters).FirstOrDefault();
        }

        public bool hasScenarios(int materialFilterId)
        {
            var parameters = new
            {
                id = materialFilterId
            };
            
            var countScenarios = _baseRepository.GetQueryResult<int>(MaterialFilterQuery.GetCountScenarios, parameters).FirstOrDefault();

            if(countScenarios > 0){
                return true;
            }
            
            return false;
        }
    }
}
