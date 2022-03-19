using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories
{
    public class ProductionUnitGroupRepository : IProductionUnitGroupRepository
    {
        private readonly IBaseRepository _baseRepository;

        public ProductionUnitGroupRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<ProductionUnitGroup> GetAll()
        {
            return _baseRepository.GetQueryResult<ProductionUnitGroup>(ProductionUnitGroupQuery.GetAll);
        }
    }
}
