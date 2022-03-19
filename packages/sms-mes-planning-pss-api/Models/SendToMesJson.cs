using System.Collections.Generic;
using Newtonsoft.Json;

namespace sms_mes_planning_pss_api.Models
{
    public class SendToMesJson
    {
        [JsonProperty("Program")]        
        public MesProgramAtrib MesProgram { get; set; } = new MesProgramAtrib();

        [JsonProperty("Program Line")]
        public IList<MesProgramLineAtrib> MesProgramLine { get; set; } = new List<MesProgramLineAtrib>();        

        [JsonProperty("Program Line Item")]
        public IList<MesProgramLineItemAtrib> MesProgramLineItem { get; set; } = new List<MesProgramLineItemAtrib>();        

    }

    public class MesProgramAtrib
    {        
        [JsonProperty(PropertyName = "PRODUCTION_UNIT_NAME")]
        public string PRODUCTION_UNIT_NAME { get; set; } = "";

        [JsonProperty(PropertyName = "PROGRAM_STYLE")]
        public int PROGRAM_STYLE { get; set; } = 0;

        [JsonProperty(PropertyName = "START_DATE")]
        public string START_DATE { get; set; } = "";

        [JsonProperty(PropertyName = "DURATION")]
        public string DURATION { get; set; } = "";

        [JsonProperty(PropertyName = "REMARK")]
        public string REMARK { get; set; } = "";

        [JsonProperty(PropertyName = "SETUP_TIME_BEFORE")]
        public int SETUP_TIME_BEFORE { get; set; } = 0;

        [JsonProperty(PropertyName = "SETUP_TIME_AFTER")]
        public int SETUP_TIME_AFTER { get; set; } = 0;

        [JsonProperty(PropertyName = "PROGRAM_TYPE")]
        public int PROGRAM_TYPE { get; set; } = 0;
    }
    public class MesProgramLineAtrib
    {
        [JsonProperty(PropertyName = "PROGRAM_LINE_LEVEL1")]
        public int PROGRAM_LINE_LEVEL1 { get; set; } = 0;

        [JsonProperty(PropertyName = "PROGRAM_LINE_LEVEL2")]
        public int PROGRAM_LINE_LEVEL2 { get; set; } = 0;

        [JsonProperty(PropertyName = "PRODUCTION_UNIT_NAME")]
        public string PRODUCTION_UNIT_NAME { get; set; } = "";

        [JsonProperty(PropertyName = "PRODUCTION_ORDER_ID")]
        public string PRODUCTION_ORDER_ID { get; set; } = "";

        [JsonProperty(PropertyName = "PRODUCTION_STEP_ID")]
        public string PRODUCTION_STEP_ID { get; set; } = "0";

        [JsonProperty(PropertyName = "DURATION")]
        public int DURATION { get; set; } = 0;

        [JsonProperty(PropertyName = "PROGRAM_ITEM_NO")]
        public int PROGRAM_ITEM_NO { get; set; } = 0;

        [JsonProperty(PropertyName = "HEAT_WEIGHT")]
        public string HEAT_WEIGHT { get; set; } = "0";

        [JsonProperty(PropertyName = "TREATMENT_NO")]
        public int TREATMENT_NO { get; set; } = 0;

        [JsonProperty(PropertyName = "REMARK")]
        public string REMARK { get; set; } = "";

        [JsonProperty(PropertyName = "STEEL_GRADE_INT")]
        public string STEEL_GRADE_INT { get; set; } = "";

        [JsonProperty(PropertyName = "HEAT_GROUP")]
        public int HEAT_GROUP { get; set; } = 0;
    }
    public class MesProgramLineItemAtrib
    { 
        [JsonProperty(PropertyName = "PROGRAM_LINE_LEVEL1")]
        public int PROGRAM_LINE_LEVEL1 { get; set; } = 0;

        [JsonProperty(PropertyName = "PROGRAM_LINE_LEVEL2")]
        public int PROGRAM_LINE_LEVEL2 { get; set; } = 0;

        [JsonProperty(PropertyName = "PROGRAM_LINE_OUTPUT")]
        public int PROGRAM_LINE_OUTPUT { get; set; } = 0;

        [JsonProperty(PropertyName = "PRODUCTION_UNIT_NAME")]
        public string PRODUCTION_UNIT_NAME { get; set; } = "";

        [JsonProperty(PropertyName = "PRODUCTION_ORDER_ID")]
        public string PRODUCTION_ORDER_ID { get; set; } = "";

        [JsonProperty(PropertyName = "PRODUCTION_STEP_ID")]
        public string PRODUCTION_STEP_ID { get; set; } = "0";

        [JsonProperty(PropertyName = "COIL_THICKNESS_AIM")]
        public string COIL_THICKNESS_AIM { get; set; } = "0";

        [JsonProperty(PropertyName = "COIL_WIDTH_AIM")]
        public string COIL_WIDTH_AIM { get; set; } = "0";

        [JsonProperty(PropertyName = "COIL_LENGTH_AIM")]
        public string COIL_LENGTH_AIM { get; set; } = "0";

        [JsonProperty(PropertyName = "COIL_WEIGHT_AIM")]
        public string COIL_WEIGHT_AIM { get; set; } = "0";

        [JsonProperty(PropertyName = "DURATION")]
        public string DURATION { get; set; } = "0";
                
        [JsonProperty(PropertyName = "REMARK")]
        public string REMARK { get; set; } = "0";

        [JsonProperty(PropertyName = "SLAB_THICKNESS_AIM")]
        public string SLAB_THICKNESS_AIM { get; set; } = "0";

        [JsonProperty(PropertyName = "TRANSITION_FLAG")]
        public int TRANSITION_FLAG { get; set; } = 0;

        [JsonProperty(PropertyName = "STEEL_DESIGN_CD")]
        public string STEEL_DESIGN_CD { get; set; } = "";

        [JsonProperty(PropertyName = "OVERPRODUCTION_FLAG")]
        public int OVERPRODUCTION_FLAG { get; set; } = 0;

        [JsonProperty(PropertyName = "SLAB_WIDTH_AIM")]
        public string SLAB_WIDTH_AIM { get; set; } = "0";

        [JsonProperty(PropertyName = "STEEL_GRADE_INT")]
        public string STEEL_GRADE_INT { get; set; } = "";
        
    }

}
