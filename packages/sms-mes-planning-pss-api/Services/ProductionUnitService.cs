using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services
{
    public class ProductionUnitService : IProductionUnitService
    {
        private readonly IProductionUnitRepository _productionUnitRepository;

        public ProductionUnitService(IProductionUnitRepository productionUnitRepository)
        {
            _productionUnitRepository = productionUnitRepository;
        }

        public IEnumerable<ProductionUnit> GetAll()
        {
            return _productionUnitRepository.GetAll();
        }

        public IEnumerable<ProductionUnit> GetByProductionUnitGroupId(int productionUnitGroup)
        {
            return _productionUnitRepository.GetByProductionUnitGroupId(productionUnitGroup);
        }
        
        public IEnumerable<ProductionUnit> GetCastersByProductionUnitGroupId(int productionUnitGroup)
        {
            return _productionUnitRepository.GetCastersByProductionUnitGroupId(productionUnitGroup);
        }
    }
}
