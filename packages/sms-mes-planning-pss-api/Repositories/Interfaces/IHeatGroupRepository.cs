using sms_mes_planning_pss_api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IHeatGroupRepository
    {
        int Add(int unitSequenceId, int groupNumber, string heatSteelGradeInt = "");
        void Update(int GroupNumber, int UnitSequenceId, string HeatSteelGradeInt);
        void Delete(int Id);
        int GetNextGroupNumber();
        HeatGroup GetHeatAtributesByGroupNumber(int GroupNumber);
        HeatGroup GetHeatGroupById(int HeatGroupId);
    }
}
