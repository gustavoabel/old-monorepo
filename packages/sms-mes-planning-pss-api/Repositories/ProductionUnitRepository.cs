using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories
{
    public class ProductionUnitRepository : IProductionUnitRepository
    {
        private readonly IBaseRepository _baseRepository;

        public ProductionUnitRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<ProductionUnit> GetByProductionUnitGroupId(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<ProductionUnit>(ProductionUnitQuery.GetByProductionUnitGroup, parameters);
        }

        public IEnumerable<ProductionUnit> GetCastersByProductionUnitGroupId(int productionUnitGroupId)
        {
            var parameters = new
            {
                productionUnitGroupId
            };
            return _baseRepository.GetQueryResult<ProductionUnit>(ProductionUnitQuery.GetCastersByProductionUnitGroupId, parameters);
        }

        public IEnumerable<ProductionUnit> GetAll()
        {
            return _baseRepository.GetQueryResult<ProductionUnit>(ProductionUnitQuery.GetAll);
        }

        public IEnumerable<OptimizerProductionUnit> GetOptimizerProductionUnits()
        {
            return _baseRepository.GetQueryResult<OptimizerProductionUnit>(ProductionUnitQuery.GetOptimizerProductionUnits);
        }
    }
}
