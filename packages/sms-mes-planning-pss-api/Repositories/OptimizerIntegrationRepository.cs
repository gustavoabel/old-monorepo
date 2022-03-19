using System;
using System.Linq;

using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class OptimizerIntegrationRepository : IOptimizerIntegrationRepository
    {
        private readonly IBaseRepository _baseRepository;

        public OptimizerIntegrationRepository(
            IBaseRepository baseRepository
        )
        {
            _baseRepository = baseRepository;
        }

        public bool GetStatusIntegration()
        {
            return _baseRepository.GetQueryResult<bool>(OptimizerIntegrationQuery.GetStatusIntegration).FirstOrDefault();
        }
        public int GetCountIntegration()
        {
            return _baseRepository.GetQueryResult<int>(OptimizerIntegrationQuery.GetCountIntegration).FirstOrDefault();
        }

        public void SetTaskStatus(bool status)
        {
            _baseRepository.RunQuery(OptimizerIntegrationQuery.SetTaskStatus, new { Status = status });
        }

        public void SetNewIntegration()
        {
            _baseRepository.RunQuery(OptimizerIntegrationQuery.SetNewIntegration);
        }
    }
}