using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class InputMaterialRepository : IInputMaterialRepository
    {
        private readonly IBaseRepository _baseRepository;

        public InputMaterialRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public void Add(InputOutputMaterial inputMaterial)
        {
            var parameters = new
            {
                material_order = inputMaterial.MaterialOrder,
                sequence_item_id = inputMaterial.SequenceItemId,
                material_id = inputMaterial.MaterialId
            };
            _baseRepository.RunQuery(InputMaterialQuery.Add, parameters);
        }

        public InputOutputMaterial GetBySequenceItem(int SequenceItemId)
        {
            var parameters = new
            {
                SequenceItemId = SequenceItemId
            };


            return _baseRepository.GetQueryResult<InputOutputMaterial>(InputMaterialQuery.GetBySequenceItem, parameters).FirstOrDefault();
        }
    }
}
