using System;
using System.Collections.Generic;
using Newtonsoft.Json;

namespace sms_mes_planning_pss_api.Models
{    
    public class MaterialsMES
    { 
        [JsonProperty(PropertyName = "ps_piece_id")]
        public string PS_PIECE_ID { get; set; } = "0";

        [JsonProperty(PropertyName = "production_order_id_target")]
        public string PRODUCTION_ORDER_ID_TARGET { get; set; } = "";

        [JsonProperty(PropertyName = "production_step_id_target")]
        public string PRODUCTION_STEP_ID_TARGET { get; set; } = "0";

        [JsonProperty(PropertyName = "thickness_target")]
        public string THICKNESS_TARGET { get; set; } = "0";

        [JsonProperty(PropertyName = "width_target")]
        public string WIDTH_TARGET { get; set; } = "0";

        [JsonProperty(PropertyName = "length_target")]
        public string LENGTH_TARGET { get; set; } = "0";

        [JsonProperty(PropertyName = "weight_target")]
        public string WEIGHT_TARGET { get; set; } = "0";

        [JsonProperty(PropertyName = "duration")]
        public string DURATION { get; set; } = "0";
                
        [JsonProperty(PropertyName = "remark")]
        public string REMARK { get; set; } = "0";

        [JsonProperty(PropertyName = "slab_thickness_target")]
        public string SLAB_THICKNESS_TARGET { get; set; } = "0";

        [JsonProperty(PropertyName = "TRANSITION_FLAG")]
        public int TRANSITION_FLAG { get; set; } = 0;

        [JsonProperty(PropertyName = "steel_design_cd")]
        public string STEEL_DESIGN_CD { get; set; } = "";

        [JsonProperty(PropertyName = "slab_width")]
        public string SLAB_WIDTH { get; set; } = "0";

        [JsonProperty(PropertyName = "steel_grade_int")]
        public string STEEL_GRADE_INT { get; set; } = "0";
    }

}
