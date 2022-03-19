using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class SequenceItemRepository : ISequenceItemRepository
    {
        private readonly IBaseRepository _baseRepository;

        public SequenceItemRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public int Add(SequenceItem sequenceItem)
        {
            var parameters = new
            {
                item_order = sequenceItem.ItemOrder,
                unit_sequence_id = sequenceItem.UnitSequenceId,
                heat_group_id = sequenceItem.HeatGroupId
            };

            return _baseRepository.GetQueryResult<int>(SequenceItemQuery.Add, parameters).FirstOrDefault();
        }
        public ProductionUnit GetUnitTypeBySequenceItem(int SequenceItemId)
        {
            return _baseRepository.GetQueryResult<ProductionUnit>(SequenceItemQuery.GetProductionUnitBySequenceItem, new { sequenceItemId = SequenceItemId }).SingleOrDefault();
        }
        public int GetHeatGroupIdByItemOrder(int ItemOrder, int UnitSequenceId)
        {
            return _baseRepository.GetQueryResult<int>(SequenceItemQuery.GetHeatGroupIdByItemOrder, new { itemOrder = ItemOrder, unitSequenceId = UnitSequenceId }).SingleOrDefault();
        }
        public int GetHeatGroupIdById(int Id)
        {
            return _baseRepository.GetQueryResult<int>(SequenceItemQuery.GetHeatGroupIdById, new { id = Id }).SingleOrDefault();
        }
        public int GetCountHeatGroup(int HeatGroupId)
        {
            return _baseRepository.GetQueryResult<int>(SequenceItemQuery.GetCountHeatGroup, new { heatGroupId = HeatGroupId }).SingleOrDefault();
        }
    }
}
