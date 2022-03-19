using System;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IOptimizerIntegrationRepository
    {        
        bool GetStatusIntegration();
        void SetNewIntegration();
        void SetTaskStatus(bool status);
        int GetCountIntegration();
    }
}
