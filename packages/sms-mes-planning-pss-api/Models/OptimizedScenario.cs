using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Models
{
    public class OptimizedScenario
    {
        [JsonPropertyName("SCENARIO_ID")]
        public int ScenarioId { get; set; }

        [JsonPropertyName("JOBS")]
        public IEnumerable<OptimizedScenarioJob> Jobs { get; set; }
    }
}
