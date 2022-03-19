using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Models
{
    public class OptimizerInput
    {
        [JsonPropertyName("SCENARIO_ID")]
        public string SCENARIO_ID { get; set; }

        [JsonPropertyName("PRODUCTION_UNITS")]
        public IEnumerable<OptimizerProductionUnit> PRODUCTION_UNITS { get; set; }

        [JsonPropertyName("JOBS")]
        public IEnumerable<dynamic> JOBS { get; set; }
    }
}
