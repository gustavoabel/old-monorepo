using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class OutputMaterialRepository : IOutputMaterialRepository
    {
        private readonly IBaseRepository _baseRepository;

        public OutputMaterialRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public void Add(InputOutputMaterial outputMaterial)
        {
            var parameters = new
            {
                material_order = outputMaterial.MaterialOrder,
                sequence_item_id = outputMaterial.SequenceItemId,
                material_id = outputMaterial.MaterialId
            };
            _baseRepository.RunQuery(OutputMaterialQuery.Add, parameters);
        }
    }
}
