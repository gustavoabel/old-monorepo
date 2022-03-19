using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services
{
    public class MaterialTypeService : IMaterialTypeService
    {
        private readonly IMaterialTypeRepository _materialTypeRepository;

        public MaterialTypeService(IMaterialTypeRepository materialTypeRepository)
        {
            _materialTypeRepository = materialTypeRepository;
        }

        public IEnumerable<MaterialType> GetByProductionUnitId(int productionUnitId)
        {
            return _materialTypeRepository.GetByProductionUnitId(productionUnitId);
        }
    }
}
