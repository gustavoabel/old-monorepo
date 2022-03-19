using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Models
{
    public class OptimizerProductionUnit
    {
        [JsonPropertyName("PRODUCTION_UNIT_ID")]
        public string PRODUCTION_UNIT_ID { get; set; } = "";

        [JsonPropertyName("HEAT_LIMIT")]
        public int HEAT_LIMIT { get; set; } = 0;

        [JsonPropertyName("HEAT_LIMIT_TOLERANCE")]
        public int HEAT_LIMIT_TOLERANCE { get; set; } = 0;

        [JsonPropertyName("SEQUENCE_SIZE")]
        public int SEQUENCE_SIZE { get; set; } = 0;
    }
}
