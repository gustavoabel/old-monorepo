using sms_mes_planning_pss_api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface ISequenceItemRepository
    {
        int Add(SequenceItem sequenceItem);
        ProductionUnit GetUnitTypeBySequenceItem(int SequenceItemId);
        int GetHeatGroupIdByItemOrder(int ItemOrder, int UnitSequenceId);
        int GetCountHeatGroup(int HeatGroupId);
        int GetHeatGroupIdById(int Id);
    }
}
