using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services
{
    public class ProductionUnitGroupService : IProductionUnitGroupService
    {
        private readonly IProductionUnitGroupRepository _productionUnitGroupRepository;

        public ProductionUnitGroupService(IProductionUnitGroupRepository productionUnitGroupRepository)
        {
            _productionUnitGroupRepository = productionUnitGroupRepository;
        }

        public IEnumerable<ProductionUnitGroup> GetAll()
        {
            return _productionUnitGroupRepository.GetAll();
        }
    }
}
