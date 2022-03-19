using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace sms_mes_planning_pss_api.Repositories
{
    public class SequenceScenarioRepository : ISequenceScenarioRepository
    {
        private readonly IBaseRepository _baseRepository;
        private readonly IGroupSequenceRepository _groupSequenceRepository;

        public SequenceScenarioRepository(IBaseRepository baseRepository, IGroupSequenceRepository groupSequenceRepository)
        {
            _baseRepository = baseRepository;
            _groupSequenceRepository = groupSequenceRepository;
        }

        public SequenceScenario GetByUnitSequenceId(int UnitSequenceId)
        {
            try
            {
                return _baseRepository.GetQueryResult<SequenceScenario>(
                    SequenceScenarioQuery.GetByUnitSequenceId,
                    new { unitSequenceId = UnitSequenceId }
               ).FirstOrDefault();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw new Exception(e.ToString());
            }
        }
        public int Add(SequenceScenario sequenceScenario)
        {
            var parameters = new
            {
                name = sequenceScenario.Name,
                remark = sequenceScenario.Remark,
                rating = sequenceScenario.Rating,
                group_sequence_id = sequenceScenario.GroupSequenceId,
                material_filter_id = sequenceScenario.MaterialFilterId,
                planning_horizon_id = sequenceScenario.PlanningHorizonId,
                is_optimized = sequenceScenario.UseOptimizer == false ? null : (bool?)!sequenceScenario.UseOptimizer
            };
            return _baseRepository.GetQueryResult<int>(SequenceScenarioQuery.Add, parameters).FirstOrDefault();
        }

        public IEnumerable<SequenceScenario> GetByGroupSequenceId(int? groupSequenceId)
        {
            StringBuilder query = new StringBuilder(SequenceScenarioQuery.GetByGroupSequenceId);
            if (groupSequenceId != null)
            {
                query.AppendLine("AND group_sequence_id = @groupSequenceId");
            }

            var parameters = new
            {
                groupSequenceId
            };

            return _baseRepository.GetQueryResult<SequenceScenario>(query.ToString(), parameters);
        }

        public SequenceScenario GetBySequenceItemId(int sequenceItemId)
        {
            return _baseRepository.GetQueryResult<SequenceScenario>(
                SequenceScenarioQuery.GetBySequenceItemId,
                new { sequenceItemId }
            ).FirstOrDefault();
        }

        public void Delete(int id)
        {
            var scenarioParameters = new
            {
                id
            };

            _baseRepository.RunQuery(SequenceScenarioQuery.Delete, scenarioParameters);

            var groupSequenceId = _baseRepository.GetQueryResult<int>(SequenceScenarioQuery.GetGroupSequenceIdByScenarioId, scenarioParameters).FirstOrDefault();

            var sequenceParameters = new
            {
                groupSequenceId
            };

            var scenarios = _baseRepository.GetQueryResult<int>(SequenceScenarioQuery.CountScenarios, sequenceParameters).FirstOrDefault();

            if (scenarios == 0)
            {
                _groupSequenceRepository.Delete(groupSequenceId);
            }
        }

        public SequenceScenario GetDuplicate(SequenceScenario sequenceScenario)
        {
            var parameters = new
            {
                groupSequenceId = sequenceScenario.GroupSequenceId,
                materialFilterId = sequenceScenario.MaterialFilterId,
                planningHorizonId = sequenceScenario.PlanningHorizonId
            };
            return _baseRepository.GetQueryResult<SequenceScenario>(SequenceScenarioQuery.GetDuplicate, parameters).FirstOrDefault();
        }

        public void Update(SequenceScenario sequenceScenario)
        {
            var parameters = new
            {
                id = sequenceScenario.Id,
                name = sequenceScenario.Name,
                remark = sequenceScenario.Remark,
                rating = sequenceScenario.Rating,
                materialFilterId = sequenceScenario.MaterialFilterId,
                planningHorizonId = sequenceScenario.PlanningHorizonId
            };
            _baseRepository.RunQuery(SequenceScenarioQuery.Update, parameters);
        }

        public void ChangeOptimizedScenario(int SequenceScenarioId, int GroupSequenceId, int? MaterialFilterId, int? PlanningHorizonId)
        {
            var parameters = new
            {
                sequenceScenarioId = SequenceScenarioId,
                groupSequenceId = GroupSequenceId,
                materialFilterId = MaterialFilterId,
                planningHorizonId = PlanningHorizonId
            };
            _baseRepository.RunQuery(SequenceScenarioQuery.ChangeOptimizedScenario, parameters);
        }

        public bool SelectActualSequenceScenario(int sequenceScenarioId, int groupSequenceId)
        {
            try
            {
                var parameters = new
                {
                    id = sequenceScenarioId,
                    groupSequenceId = groupSequenceId
                };

                _baseRepository.RunQuery(SequenceScenarioQuery.ChangeSelectedScenario, parameters);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }

        }
        public int GetSelectedSequenceScenario(int GroupSequenceId)
        {
            return _baseRepository.GetQueryResult<int>(SequenceScenarioQuery.GetSelectedSequenceScenario, new { groupSequenceId = GroupSequenceId }).SingleOrDefault();
        }

        public IEnumerable<SequenceScenario> GetPedingOptimizedSequences()
        {
            return _baseRepository.GetQueryResult<SequenceScenario>(SequenceScenarioQuery.GetPedingOptimizedSequences);
        }
    }
}
