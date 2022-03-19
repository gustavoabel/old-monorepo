using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
  public interface ISmsIntegrationBaseRepository
  {
    void AddAuthHeaders(string token);
    T Put<T>(string route, object body);
    dynamic PutJsonBody (string body, string token);
    T Post<T>(string route, object body, Dictionary<string, string> parameters = null);
    T Get<T>(string route, Dictionary<string, string> parameters = null);
  }
}
