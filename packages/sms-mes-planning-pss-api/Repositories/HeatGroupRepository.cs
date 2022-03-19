using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Linq;

namespace sms_mes_planning_pss_api.Repositories
{
    public class HeatGroupRepository : IHeatGroupRepository
    {
        private readonly IBaseRepository _baseRepository;

        public HeatGroupRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public int Add(int unitSequenceId, int groupNumber, string heatSteelGradeInt = "")
        {
            var parameters = new
            {
                group_number = groupNumber,
                unit_sequence_id = unitSequenceId,
                heat_steel_grade_int = heatSteelGradeInt
            };

            return _baseRepository.GetQueryResult<int>(HeatGroupQuery.Add, parameters).FirstOrDefault();
        }

        public void Delete(int Id)
        {
            _baseRepository.RunQuery(HeatGroupQuery.Delete, new { id = Id });
        }

        public void Update(int GroupNumber, int UnitSequenceId, string HeatSteelGradeInt)
        {
            var parameters = new
            {
                groupNumber = GroupNumber,
                unitSequenceId = UnitSequenceId,                
                heatSteelGradeInt = HeatSteelGradeInt
            };

            _baseRepository.RunQuery(HeatGroupQuery.Update, parameters);
        }

        public HeatGroup GetHeatGroupById(int HeatGroupId)
        {
            return _baseRepository.GetQueryResult<HeatGroup>(HeatGroupQuery.GetById, new { heatGroupId = HeatGroupId }).SingleOrDefault();
        }

        public HeatGroup GetByGroupNumber(int GroupNumber)
        {
            return _baseRepository.GetQueryResult<HeatGroup>(HeatGroupQuery.GetByGroupNumber, new { groupNumber = GroupNumber }).SingleOrDefault();
        }

        public HeatGroup GetHeatAtributesByGroupNumber(int GroupNumber)
        {
            return _baseRepository.GetQueryResult<HeatGroup>(HeatGroupQuery.GetHeatAtributesByGroupNumber, new { groupNumber = GroupNumber }).SingleOrDefault();
        }
        public int GetNextGroupNumber()
        {
            return _baseRepository.GetQueryResult<int>(HeatGroupQuery.GetNextGroupNumber).SingleOrDefault();
        }
    }
}
