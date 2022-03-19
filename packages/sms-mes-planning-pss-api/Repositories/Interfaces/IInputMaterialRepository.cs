using sms_mes_planning_pss_api.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IInputMaterialRepository
    {
        void Add(InputOutputMaterial inputMaterial);
        InputOutputMaterial GetBySequenceItem(int SequenceItemId);
    }
}
