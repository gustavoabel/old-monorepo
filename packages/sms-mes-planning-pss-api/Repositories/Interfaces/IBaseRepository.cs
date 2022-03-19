using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IBaseRepository
    {
        void RunQuery(string query, object parameters = null);

        IEnumerable<T> GetQueryResult<T>(string query, object parameters = null);
    }
}
