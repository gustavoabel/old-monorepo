using Newtonsoft.Json;

namespace sms_mes_planning_pss_api.Models
{
    public class MaterialAttributeDefinition
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Type { get; set; }
    }

    public class CustomColumn 
    {
        [JsonProperty(PropertyName = "field")]
        public string Field {get; set;}
        
        [JsonProperty(PropertyName = "title")]
        public string Title {get; set;}
    }
}
