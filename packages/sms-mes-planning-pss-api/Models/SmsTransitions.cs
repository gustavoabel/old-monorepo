using System;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Models
{

    public class MESTransition
    {
        public string FROM { get; set; }
        public string TO { get; set; }
        public string CLASSIFICATION { get; set; }
        public int ACTIVE_FLAG { get; set; }
        public DateTime MODIFICATION_DATE { get; set; }
    }
    public class IntegratedTransitions
    {
        public string ATTRIBUTE { get; set; }
        public IEnumerable<MESTransition> TRANSITION { get; set; }
    }
}