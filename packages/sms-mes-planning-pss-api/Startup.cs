using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Serilog;
using sms_mes_planning_pss_api.Configuration;

namespace sms_mes_planning_pss_api
{
    public class Startup
    {
        public Startup(IConfiguration configuration, IWebHostEnvironment env)
        {
            Configuration = configuration;
            Environment = env;
        }

        public IConfiguration Configuration { get; }
        public IWebHostEnvironment Environment { get; }

        public void ConfigureServices(IServiceCollection services)
        {
            services.RegisterServices();
            services.AddApiConfiguration(Configuration);
            services.AddSwaggerConfiguration();
        }

        public void Configure(IApplicationBuilder app, ILogger<Startup> logger)
        {
            if (Environment.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwaggerConfiguration();
            }                        
            app.UseApiConfiguration(Environment);
            app.UseAuthConfiguration();
            app.UseSerilogRequestLogging();
        }        
    }
}
   
