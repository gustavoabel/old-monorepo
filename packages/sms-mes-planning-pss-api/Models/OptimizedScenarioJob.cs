using System.Text.Json.Serialization;

namespace sms_mes_planning_pss_api.Models
{
    public class OptimizedScenarioJob
    {
        [JsonPropertyName("PRODUCTION_UNIT")]
        public int ProductionUnitId { get; set; }

        [JsonPropertyName("HEAT_POS")]
        public int HeatPosition { get; set; }

        [JsonPropertyName("SLAB_POS")]
        public int SlabPosition { get; set; }

        [JsonPropertyName("PS_PIECE_ID")]
        public string PieceId { get; set; }
    }
}
