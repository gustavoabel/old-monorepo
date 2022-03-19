using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json.Linq;
using Serilog;
using Serilog.Formatting.Json;
using Serilog.Sinks.Datadog;
using System;
using System.Data;
using static Dapper.SqlMapper;

namespace sms_mes_planning_pss_api
{
    public class Program
    {
        public static void Main(string[] args)
        {   
            var configuration = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json")
                .Build();

            var datadogConf = new DatadogConfiguration();

            Log.Logger = new LoggerConfiguration()
                .ReadFrom.Configuration(configuration)
                .Enrich.FromLogContext()                
                .WriteTo.File(new JsonFormatter(renderMessage: true), "pss-api.log") //Write in a file on the project root 
                .WriteTo.Datadog(datadogConf) //Write in Datadog panel
                .CreateLogger();

            try
            {
                Log.Information("PSS - Application Starting Up.");
                CreateHostBuilder(args).Build().Run();
            }
            catch (Exception ex)
            {
                Log.Fatal(ex, "PSS - The application failed to start.");
            }
            finally
            {
                Log.CloseAndFlush();
            }
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .UseSerilog()                
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });

        class JObjectHandler : TypeHandler<JObject>
        {
            private JObjectHandler() { }
            public static JObjectHandler Instance { get; } = new JObjectHandler();
            public override JObject Parse(object value)
            {
                var json = (string)value;
                return json == null ? null : JObject.Parse(json);
            }
            public override void SetValue(IDbDataParameter parameter, JObject value)
            {
                parameter.Value = value?.ToString(Newtonsoft.Json.Formatting.None);

            }
        }
    }
}
