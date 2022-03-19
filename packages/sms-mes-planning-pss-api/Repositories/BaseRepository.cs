using Dapper;
using Microsoft.Extensions.Configuration;
using Npgsql;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories
{
    public class BaseRepository : IBaseRepository
    {
        private readonly IConfiguration _configuration;
        private readonly string connStr;

        public BaseRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            connStr = _configuration.GetConnectionString("PSS");
        }

        public void RunQuery(string query, object parameters = null)
        {
            using (var conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                conn.Query(query, parameters);
            }
        }

        public IEnumerable<T> GetQueryResult<T>(string query, object parameters = null)
        {
            using (var conn = new NpgsqlConnection(connStr))
            {
                conn.Open();
                return conn.Query<T>(query, parameters);
            }
        }
    }
}
