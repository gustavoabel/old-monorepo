using Microsoft.AspNetCore.WebUtilities;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using RestSharp;
using RestSharp.Authenticators;

namespace sms_mes_planning_pss_api.Repositories
{
    public class SmsIntegrationBaseRepository : ISmsIntegrationBaseRepository
    {
        private readonly HttpClient _httpClient;
        public readonly IConfigurationSection _mesConfigAddress;
        public readonly IConfigurationSection _PSSConfigAddress;

        public SmsIntegrationBaseRepository(string Integration, IConfiguration configuration)
        {
            _httpClient = new HttpClient();
            _mesConfigAddress = configuration.GetSection("SMS");
            _PSSConfigAddress = configuration.GetSection("PSS");
            _httpClient.BaseAddress = new Uri(_mesConfigAddress.GetValue<string>(Integration));
            _httpClient.Timeout = TimeSpan.FromHours(2);
        }

        public void AddAuthHeaders(string token)
        {
            _httpClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
        }

        public T Put<T>(string route, object body)
        {
            StringContent jsonBody = GetJsonBody(body);

            using HttpResponseMessage httpResponse = _httpClient.PutAsync(route, jsonBody).Result;
            httpResponse.EnsureSuccessStatusCode();

            return GetDeserializedResponse<T>(httpResponse);
        }

        public dynamic PutJsonBody(string body, string token)
        {
            Encoding iso = Encoding.GetEncoding("ISO-8859-1");
            Encoding utf8 = Encoding.UTF8;
            byte[] utfBytes = utf8.GetBytes(body);
            byte[] isoBytes = Encoding.Convert(utf8, iso, utfBytes);
            string msg = iso.GetString(isoBytes);
            var uriSendToMes = new Uri(String.Concat(_mesConfigAddress.GetValue<string>("MES"), _PSSConfigAddress.GetValue<string>("RouteSendToMES")));

            var client = new RestClient(uriSendToMes)
            {
                Timeout = -1,
                Authenticator = new OAuth2AuthorizationRequestHeaderAuthenticator(token, "Bearer")
            };
            
            var request = new RestRequest(Method.PUT);
            request.AddHeader("Content-Type", "application/json");            
            request.AddParameter("application/json", msg, ParameterType.RequestBody);

            IRestResponse response = client.Execute(request);

            return response;
        }


        public T Post<T>(string route, object body, Dictionary<string, string> parameters = null)
        {
            string requestUri = GetRequestUri(route, parameters);

            try
            {
                StringContent jsonBody = GetJsonBody(body);

                using HttpResponseMessage httpResponse = _httpClient.PostAsync(requestUri, jsonBody).Result;
                httpResponse.EnsureSuccessStatusCode();                

                return GetDeserializedResponse<T>(httpResponse);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }

        }

        public T Get<T>(string route, Dictionary<string, string> parameters = null)
        {
            string requestUri = GetRequestUri(route, parameters);

            try
            {
                using HttpResponseMessage httpResponse = _httpClient.GetAsync(requestUri).Result;
                httpResponse.EnsureSuccessStatusCode();

                return GetDeserializedResponse<T>(httpResponse);
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine(e.GetBaseException());
                Console.WriteLine(e.Message);
                throw;
            }
        }

        private StringContent GetJsonBody(object body)
        {
            return new StringContent(
                JsonSerializer.Serialize(body),
                Encoding.UTF8,
                "application/json");
        }

        private T GetDeserializedResponse<T>(HttpResponseMessage httpResponse)
        {
            string response = httpResponse.Content.ReadAsStringAsync().Result;

            return JsonSerializer.Deserialize<T>(response);
        }

        private string GetRequestUri(string route, Dictionary<string, string> parameters)
        {
            return parameters != null ? QueryHelpers.AddQueryString(route, parameters) : route;
        }
    }
}
