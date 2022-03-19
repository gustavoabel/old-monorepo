using sms_mes_planning_pss_api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IOptimizerService
    {
        bool CreateOptimizedScenario(int sequenceScenarioId, int groupSequenceId, int? materialFilterId, int? planningHorizonId, IEnumerable<UnitSequence> addedUnitSequences);
    }
}
