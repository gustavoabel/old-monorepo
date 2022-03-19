using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Models
{
    public class SequenceItem
    {
        public int Id { get; set; }
        public int ItemOrder { get; set; }
        public int UnitSequenceId { get; set; }
        public int? HeatGroupId { get; set; }
    }
}
