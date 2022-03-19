using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Models
{

    public class Transition
    {
        public int Id { get; set; }
        public int MaterialAttributeDefinitionId { get; set; }
        public string MaterialAttributeDefinitionName { get; set; }
        public string From { get; set; }
        public string To { get; set; }
        public string Classification { get; set; }
        public int Active_Flag { get; set; }
        public DateTime Modification_Date { get; set; }
    }

    public class NewTransition
    {
        public int Attribute { get; set; }
        public string From { get; set; }
        public string To { get; set; }
        public string Classification { get; set; }
        public bool Active { get; set; }
    }
}