using Microsoft.Extensions.DependencyInjection;
using sms_mes_planning_pss_api.Repositories;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services;
using sms_mes_planning_pss_api.Services.Interfaces;

namespace sms_mes_planning_pss_api.Configuration
{
    public static class DependencyInjectionConfig
    {
        public static void RegisterServices(this IServiceCollection services)
        {
            #region Services
            services.AddTransient<IProductionUnitGroupService, ProductionUnitGroupService>();
            services.AddTransient<IPlanningHorizonService, PlanningHorizonService>();
            services.AddTransient<IMaterialFilterService, MaterialFilterService>();
            services.AddTransient<IMaterialAttributeDefinitionService, MaterialAttributeDefinitionService>();
            services.AddTransient<IGroupSequenceService, GroupSequenceService>();
            services.AddTransient<ISequenceScenarioService, SequenceScenarioService>();
            services.AddTransient<ISequenceScenarioVersionService, SequenceScenarioVersionService>();
            services.AddTransient<IUnitSequenceService, UnitSequenceService>();      
            services.AddTransient<IProductionUnitService, ProductionUnitService>();
            services.AddTransient<ISchedulingRuleService, SchedulingRuleService>();
            services.AddTransient<IMaterialTypeService, MaterialTypeService>();
            services.AddTransient<IMaterialService, MaterialService>();
            services.AddTransient<ICodeService, CodeService>();
            services.AddTransient<IKPIService, KPIService>();
            services.AddTransient<ILimitConfigurationService, LimitConfigurationService>();
            services.AddTransient<IOptimizerService, OptimizerService>();
            services.AddTransient<ISchedulingRuleViolationService, SchedulingRuleViolationService>();            
            #endregion

            #region Repositories
            services.AddTransient<IBaseRepository, BaseRepository>();
            services.AddTransient<IProductionUnitGroupRepository, ProductionUnitGroupRepository>();
            services.AddTransient<IPlanningHorizonRepository, PlanningHorizonRepository>();
            services.AddTransient<IMaterialFilterRepository, MaterialFilterRepository>();
            services.AddTransient<IMaterialAttributeDefinitionRepository, MaterialAttributeDefinitionRepository>();
            services.AddTransient<IMesIntegrationRepository, MesIntegrationRepository>();
            services.AddTransient<IGroupSequenceRepository, GroupSequenceRepository>();
            services.AddTransient<ISequenceScenarioRepository, SequenceScenarioRepository>();
            services.AddTransient<ISequenceScenarioVersionRepository, SequenceScenarioVersionRepository>();
            services.AddTransient<IUnitSequenceRepository, UnitSequenceRepository>();
            services.AddTransient<IProductionUnitRepository, ProductionUnitRepository>();
            services.AddTransient<ISchedulingRuleRepository, SchedulingRuleRepository>();
            services.AddTransient<IMaterialTypeRepository, MaterialTypeRepository>();
            services.AddTransient<IMaterialRepository, MaterialRepository>();
            services.AddTransient<IKPIRepository, KPIRepository>();
            services.AddTransient<ILimitConfigurationRepository, LimitConfigurationRepository>();
            services.AddTransient<ISequenceItemRepository, SequenceItemRepository>();
            services.AddTransient<IInputMaterialRepository, InputMaterialRepository>();
            services.AddTransient<IOutputMaterialRepository, OutputMaterialRepository>();
            services.AddTransient<ISchedulingRuleViolationRepository, SchedulingRuleViolationRepository>();
            services.AddTransient<IHeatGroupRepository, HeatGroupRepository>();
            services.AddTransient<ITransitionRepository, TransitionRepository>();
            services.AddTransient<IOptimizerIntegrationRepository, OptimizerIntegrationRepository>();
            #endregion

            #region BackgroundServices
            services.AddHostedService<MesIntegrationService>();            
            services.AddHostedService<OptimizerService>();
            #endregion
        }
    }
}
