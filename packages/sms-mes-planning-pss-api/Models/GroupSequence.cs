using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Models
{
    public class GroupSequence
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime StartDate { get; set; }
        public string Remark { get; set; }
        public string PlanningStatus { get; set; }
        public string ExecutionStatus { get; set; }
        public int ProductionUnitGroupId { get; set; }
        public int? PredecessorSequenceId { get; set; }
        public int? SuccessorSequenceId { get; set; }
        public IEnumerable<SequenceScenario> ScenarioList { get; set; }
    }
}
