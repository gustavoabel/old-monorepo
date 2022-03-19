using System;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IMesIntegrationRepository
    {
        Nullable<DateTime> GetLastIntegration(string IntegrationType);
        void SetIntegrationTime(string IntegrationType);
    }
}
