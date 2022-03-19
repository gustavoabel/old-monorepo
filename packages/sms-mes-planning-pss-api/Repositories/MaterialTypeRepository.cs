using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories
{
    public class MaterialTypeRepository : IMaterialTypeRepository
    {
        private readonly IBaseRepository _baseRepository;

        public MaterialTypeRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public IEnumerable<MaterialType> GetByProductionUnitId(int productionUnitId)
        {
            var parameters = new
            {
                productionUnitId
            };
            return _baseRepository.GetQueryResult<MaterialType>(MaterialTypeQuery.GetByProductionUnitId, parameters);
        }
    }
}
