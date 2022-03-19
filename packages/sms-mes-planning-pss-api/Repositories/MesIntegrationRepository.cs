using System;
using System.Linq;

using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class MesIntegrationRepository : IMesIntegrationRepository
    {
        private readonly IBaseRepository _baseRepository;

        public MesIntegrationRepository(
            IBaseRepository baseRepository
        )
        {
            _baseRepository = baseRepository;
        }

        public Nullable<DateTime> GetLastIntegration(string IntegrationType)
        {
            var parameters = new {
                type = IntegrationType
            };

            MesIntegration mt = _baseRepository.GetQueryResult<MesIntegration>(MesIntegrationQuery.GetLastIntegration, parameters).FirstOrDefault();

            if (mt != null)
            {
                return mt.LastIntegration;
            }

            return null;
        }

        public void SetIntegrationTime(string IntegrationType)
        {
            var parameters = new {
                type = IntegrationType
            };

            Nullable<DateTime> IsUpdate = GetLastIntegration(IntegrationType);

            if (IsUpdate != null) {
                _baseRepository.RunQuery(MesIntegrationQuery.UpdateIntegrationTime, parameters);
            } else {
                _baseRepository.RunQuery(MesIntegrationQuery.SetIntegrationTime, parameters);
            }
        }
    }
}