using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using System.Collections.Generic;
using sms_mes_planning_pss_api.Repositories.Queries;
using System.Linq;
using System;

namespace sms_mes_planning_pss_api.Repositories
{
    public class GroupSequenceRepository : IGroupSequenceRepository
    {
        private readonly IBaseRepository _baseRepository;

        public GroupSequenceRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }

        public int Add(GroupSequence groupSequence)
        {
            var parameters = new
            {
                name = groupSequence.Name,
                start_date = groupSequence.StartDate,
                remark = groupSequence.Remark,
                planning_status = groupSequence.PlanningStatus,
                execution_status = groupSequence.ExecutionStatus,
                production_unit_group_id = groupSequence.ProductionUnitGroupId,
                predecessor_sequence_id = groupSequence.PredecessorSequenceId,
                successor_sequence_id = groupSequence.SuccessorSequenceId
            };
            return _baseRepository.GetQueryResult<int>(GroupSequenceQuery.Add, parameters).FirstOrDefault();
        }

        public IEnumerable<GroupSequence> GetAll()
        {
            return _baseRepository.GetQueryResult<GroupSequence>(GroupSequenceQuery.GetAll);
        }

        public void Update(GroupSequence groupSequence)
        {
            var parameters = new
            {
                id = groupSequence.Id,
                name = groupSequence.Name,
                start_date = groupSequence.StartDate,
                remark = groupSequence.Remark,
                predecessor_sequence_id = groupSequence.PredecessorSequenceId,
                successor_sequence_id = groupSequence.SuccessorSequenceId
            };
            _baseRepository.RunQuery(GroupSequenceQuery.Update, parameters);
        }

        public void Delete(int groupSequenceId)
        {
            var parameters = new
            {
                id = groupSequenceId
            };
            _baseRepository.RunQuery(GroupSequenceQuery.Delete, parameters);
        }

        public GroupSequence GetById(int groupSequenceId)
        {
            var parameters = new
            {
                id = groupSequenceId
            };
            return _baseRepository.GetQueryResult<GroupSequence>(GroupSequenceQuery.GetById, parameters).FirstOrDefault();
        }
        public GroupSequence GetSequenceByScenarioId(int scenarioId)
        {
            var parameters = new
            {
                id = scenarioId
            };
            return _baseRepository.GetQueryResult<GroupSequence>(GroupSequenceQuery.GetSequenceByScenarioId, parameters).FirstOrDefault();
        }

        public bool ChangePlanningStatus(int groupSequenceId, string planningStatus)
        {
            try
            {
                var parameters = new
                {
                    id = groupSequenceId,
                    planningStatus
                };

                _baseRepository.RunQuery(GroupSequenceQuery.ChangeGroupSequenceStatus, parameters);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }

        }

        public SendToMES GetMesProgram(int GroupSequenceId, int SequenceScenarioVersionId, int ProductionUnitId)
        {
            return _baseRepository.GetQueryResult<SendToMES>(SendToMESQuery.GetMesProgram, new
            {
                groupSequenceId = GroupSequenceId,
                sequenceScenarioVersionId = SequenceScenarioVersionId,
                productionUnitId = ProductionUnitId
            }).SingleOrDefault();
        }
        public int GetDurationProgramLine(int GroupSequenceId, int SequenceScenarioVersionId, int ProductionUnitId)
        {
            return _baseRepository.GetQueryResult<int>(SendToMESQuery.GetDurationProgramLine, new
            {
                groupSequenceId = GroupSequenceId,
                sequenceScenarioVersionId = SequenceScenarioVersionId,
                productionUnitId = ProductionUnitId
            }).SingleOrDefault();
        }
    }
}
