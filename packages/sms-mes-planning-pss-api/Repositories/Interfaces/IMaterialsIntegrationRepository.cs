using System;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IMaterialsIntegrationRepository
    {
        Nullable<DateTime> GetLastIntegration();
        void SetNewIntegration();
    }
}
