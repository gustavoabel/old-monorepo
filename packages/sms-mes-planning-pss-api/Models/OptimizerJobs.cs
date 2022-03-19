using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Models
{
    public class OptimizerJobs
    {
        [JsonPropertyName("CUSTOMER_ORDER_ID")]
        public string CUSTOMER_ORDER_ID { get; set; } = "";

        [JsonPropertyName("CUSTOMER_ORDER_POS")]
        public string CUSTOMER_ORDER_POS { get; set; } = "";

        [JsonPropertyName("PIECE_ID")]
        public string PIECE_ID { get; set; } = "";

        [JsonPropertyName("PROMISED_DATE_LATEST")]
        public string PROMISED_DATE_LATEST { get; set; } = "";

        [JsonPropertyName("STEEL_GRADE_ID_INT")]
        public string STEEL_GRADE_ID_INT { get; set; } = "";

        [JsonPropertyName("SLAB_WIDTH_AIM")]
        public string SLAB_WIDTH_AIM { get; set; } = "";

        [JsonPropertyName("STEEL_DESIGN")]
        public string STEEL_DESIGN { get; set; } = "";

        [JsonPropertyName("SLAB_THICKNESS_AIM")]
        public string SLAB_THICKNESS_AIM { get; set; } = "";

        [JsonPropertyName("SLAB_LENGTH_AIM")]
        public string SLAB_LENGTH_AIM { get; set; } = "";

        [JsonPropertyName("COIL_WIDTH_AIM")]
        public string COIL_WIDTH_AIM { get; set; } = "";

        [JsonPropertyName("COIL_THICKNESS_AIM")]
        public string COIL_THICKNESS_AIM { get; set; } = "";

        [JsonPropertyName("COIL_LENGTH_AIM")]
        public string COIL_LENGTH_AIM { get; set; } = "";

        [JsonPropertyName("WEIGHT_AIM")]
        public string WEIGHT_AIM { get; set; } = "";

        [JsonPropertyName("FLAG_CUMULATIVE_ORDER")]
        public string FLAG_CUMULATIVE_ORDER { get; set; } = "";

        [JsonPropertyName("PRODUCT_TYPE_CD")]
        public string PRODUCT_TYPE_CD { get; set; } = "";

        [JsonPropertyName("NO_FIRST_SLABS_IND")]
        public string NO_FIRST_SLABS_IND { get; set; } = "";

        [JsonPropertyName("LOW_CU")]
        public string LOW_CU { get; set; } = "";

        [JsonPropertyName("LOW_DRAFT")]
        public string LOW_DRAFT { get; set; } = "";

        [JsonPropertyName("NO_DRAFT")]
        public string NO_DRAFT { get; set; } = "";

        [JsonPropertyName("GRADE_ROLL_WEAR")]
        public string GRADE_ROLL_WEAR { get; set; } = "";

        [JsonPropertyName("SPEC_INSTRUCT_PRODUCTION")]
        public string SPEC_INSTRUCT_PRODUCTION { get; set; } = "";

        [JsonPropertyName("PERFORMANCE_DUR")]
        public string PERFORMANCE_DUR { get; set; } = "";

        [JsonPropertyName("PERFORMANCE")]
        public string PERFORMANCE { get; set; } = "";
    }
}
