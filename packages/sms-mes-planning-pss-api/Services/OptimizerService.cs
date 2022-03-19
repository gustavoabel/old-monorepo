using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using Microsoft.Extensions.Configuration;
using System.Threading;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Newtonsoft.Json;
using System.Dynamic;
using Newtonsoft.Json.Converters;

namespace sms_mes_planning_pss_api.Services
{
    public class OptimizerService : IOptimizerService, IHostedService, IDisposable
    {
        private readonly IMaterialService _materialService;
        private readonly IOptimizerIntegrationRepository _optimizerIntegrationRepository;
        private readonly ISmsIntegrationBaseRepository _smsIntegrationBaseRepository;
        private readonly IProductionUnitRepository _productionUnitRepository;
        private readonly ISequenceItemRepository _sequenceItemRepository;
        private readonly ISequenceScenarioRepository _sequenceScenarioRepository;
        private readonly ISchedulingRuleViolationRepository _schedulingRuleViolationRepository;
        private readonly IMaterialRepository _materialRepository;
        private readonly IUnitSequenceRepository _unitSequenceRepository;
        private readonly IUnitSequenceService _unitSequenceService;
        private readonly IInputMaterialRepository _inputMaterialRepository;
        private readonly IHeatGroupRepository _heatGroupRepository;        
        private readonly IOutputMaterialRepository _outputMaterialRepository;
        private readonly IConfigurationSection _PSSConfigAddress;
        private readonly IConfiguration _configuration;
        private ILogger<OptimizerService> _logger;
        private readonly IServiceScopeFactory _scopeFactory;
        private Timer _time;

        public OptimizerService(
            IMaterialService materialService, 
            IProductionUnitRepository productionUnitRepository,
            ISequenceItemRepository sequenceItemRepository,
            ISequenceScenarioRepository sequenceScenarioRepository,
            IUnitSequenceRepository unitSequenceRepository,
            IUnitSequenceService unitSequenceService,
            IMaterialRepository materialRepository,
            IInputMaterialRepository inputMaterialRepository,
            IOutputMaterialRepository outputMaterialRepository,
            ISchedulingRuleViolationRepository schedulingRuleViolationRepository,
            IHeatGroupRepository heatGroupRepository,
            IOptimizerIntegrationRepository optimizerIntegrationRepository,
            IConfiguration configuration,            
            ILogger<OptimizerService> logger,
            IServiceScopeFactory scopeFactory)
        {
            _materialService = materialService;
            _smsIntegrationBaseRepository = new SmsIntegrationBaseRepository("Optimizer", configuration);
            _PSSConfigAddress = configuration.GetSection("PSS");
            _productionUnitRepository = productionUnitRepository;
            _sequenceItemRepository = sequenceItemRepository;
            _sequenceScenarioRepository = sequenceScenarioRepository;
            _materialRepository = materialRepository;
            _inputMaterialRepository = inputMaterialRepository;
            _outputMaterialRepository = outputMaterialRepository;
            _unitSequenceRepository = unitSequenceRepository;
            _unitSequenceService = unitSequenceService;
            _heatGroupRepository = heatGroupRepository;
            _optimizerIntegrationRepository = optimizerIntegrationRepository;
            _schedulingRuleViolationRepository = schedulingRuleViolationRepository;
            _logger = logger;
            _scopeFactory = scopeFactory;
            _configuration = configuration;
        }

        public void Dispose()
        {
            _time?.Dispose();
        }
        public Task StartAsync(CancellationToken cancellationToken)
        {
            int delay = _configuration.GetValue<int>("Optimizer_Timer");

            _time = new Timer(o =>
            {
                using var scope = _scopeFactory.CreateScope();
                Optimize();
            }, null, TimeSpan.Zero, TimeSpan.FromMinutes(delay));

            return Task.CompletedTask;
        }
        public Task StopAsync(CancellationToken cancellationToken)
        {
            return Task.CompletedTask;
        }

        private void Optimize()
        {
            int countIntegration = _optimizerIntegrationRepository.GetCountIntegration();

            if (countIntegration == 0)
                _optimizerIntegrationRepository.SetNewIntegration();

            bool integrationRunning = _optimizerIntegrationRepository.GetStatusIntegration();

            if (!integrationRunning)
            {
                IEnumerable<SequenceScenario> pendingScenarios = _sequenceScenarioRepository.GetPedingOptimizedSequences();

                if (pendingScenarios.Any())
                {
                    Console.WriteLine("Initiating Optimizer task.");
                    _optimizerIntegrationRepository.SetTaskStatus(true);

                    foreach (var item in pendingScenarios)
                    {
                        IEnumerable<UnitSequence> addedUnitSequences = _unitSequenceRepository.GetBySequenceScenarioId(item.Id);

                        var scenarioCreated = CreateOptimizedScenario(item.Id, item.GroupSequenceId, item.MaterialFilterId, item.PlanningHorizonId, addedUnitSequences);

                        if (scenarioCreated)
                            _sequenceScenarioRepository.ChangeOptimizedScenario(item.Id, item.GroupSequenceId, item.MaterialFilterId, item.PlanningHorizonId);
                    }

                    Console.WriteLine("Optimizer task finished.");
                    _optimizerIntegrationRepository.SetTaskStatus(false);
                }
            }
            
        }

        public bool CreateOptimizedScenario(int sequenceScenarioId, int groupSequenceId, int? materialFilterId, int? planningHorizonId, IEnumerable<UnitSequence> addedUnitSequences)
        {
            IEnumerable<dynamic> pieceIdList = _materialService.GetMaterialsGroupedByPieceId(sequenceScenarioId, groupSequenceId, materialFilterId, planningHorizonId);

            IEnumerable<dynamic> materialsList = pieceIdList.Select(m => new {
                SlabId = m.slab_id,
                CoilId = m.coil_id,
                PieceId = m.piece_id
            });

            IEnumerable<dynamic> jobsList = pieceIdList.Select(m => JsonConvert.DeserializeObject<OptimizerJobs>(m.data, new ExpandoObjectConverter()));

            if (jobsList.Any())
            {                
                OptimizedScenario optimizedScenario = GetOptimizedScenario(sequenceScenarioId.ToString(), jobsList);
                if (optimizedScenario != null)
                {
                    var addedSequenceItems = new List<SequenceItem>();
                    foreach (var job in optimizedScenario.Jobs.Select((value, index) => new { index, value }))
                    {
                        var unitSequence = addedUnitSequences.FirstOrDefault(u => u.ProductionUnitId == job.value.ProductionUnitId);

                        if (unitSequence != null)
                        {
                            CreateCasterOptimizedScenario(addedSequenceItems, job.value, unitSequence, materialsList);
                            CreateHSMOptimizedScenario(addedUnitSequences, job.value, unitSequence, materialsList);
                        }
                    }
                    // After all execution check violation rules.
                    _schedulingRuleViolationRepository.CheckViolationByScenarioId(sequenceScenarioId);

                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }

        private OptimizedScenario GetOptimizedScenario(string sequenceScenarioId, IEnumerable<dynamic> jobsList)
        {
            try
            {                
                OptimizerInput optimizerInput = new OptimizerInput()
                {
                    SCENARIO_ID = sequenceScenarioId,
                    PRODUCTION_UNITS = _productionUnitRepository.GetOptimizerProductionUnits(),
                    JOBS = jobsList
                };
                //Just for testing, getting the text json
                //var jsonRequest = JsonConvert.SerializeObject(optimizerInput);

                return _smsIntegrationBaseRepository.Put<OptimizedScenario>(_PSSConfigAddress.GetValue<string>("RouteOptimizer"), optimizerInput);
            }
            catch (Exception ex)
            {                
                string message = $"PSS - It was not possible to create an optimized scenario for the scenario {sequenceScenarioId} - Optimizer API.";
                _logger.LogError(ex, message);
                return null;
            }
        }

        private void CreateCasterOptimizedScenario(List<SequenceItem> addedSequenceItems, OptimizedScenarioJob job, UnitSequence unitSequence, IEnumerable<dynamic> materialsList)
        {
            SequenceItem sequenceItem = addedSequenceItems.FirstOrDefault(si => si.ItemOrder == (int)job.HeatPosition + 1 && si.UnitSequenceId == unitSequence.Id);
            dynamic piece = materialsList.FirstOrDefault(m => m.PieceId == job.PieceId);
            int slabId = piece.SlabId;
            int casterSequenceItemId, groupNumber, heatGroupId = 0;
            bool sameSteelGrade;

            if (sequenceItem == null)
            {
                Material Heat = _materialRepository.AddNewHeat(slabId);
                dynamic SlabInfo = _materialRepository.GetMaterialById(Heat.id);
                string newSlabSteelGradeInt = SlabInfo.STEEL_GRADE_INT;

                int lastSequenceItemOrder = _unitSequenceRepository.GetLastSequenceItemOrder(unitSequence.Id);

                if (lastSequenceItemOrder == 0) // When the table is empty
                {
                    groupNumber = _heatGroupRepository.GetNextGroupNumber();
                    heatGroupId = _heatGroupRepository.Add(unitSequence.Id, groupNumber, newSlabSteelGradeInt);
                }
                else
                {
                    // Get the Heat group from the previous record
                    HeatGroup selectedHeatGroup = _heatGroupRepository.GetHeatGroupById(_sequenceItemRepository.GetHeatGroupIdByItemOrder(lastSequenceItemOrder, unitSequence.Id));
                    sameSteelGrade = false;

                    // if exists compare with the new added slab to verify if their steel grade match
                    if (selectedHeatGroup != null)
                        if (selectedHeatGroup.HeatSteelGradeInt == newSlabSteelGradeInt)
                        {
                            groupNumber = selectedHeatGroup.GroupNumber;
                            heatGroupId = selectedHeatGroup.Id;
                            sameSteelGrade = true;
                        }
                        else
                            groupNumber = _heatGroupRepository.GetNextGroupNumber();
                    else
                        groupNumber = _heatGroupRepository.GetNextGroupNumber();

                    if (!sameSteelGrade)
                        heatGroupId = _heatGroupRepository.Add(unitSequence.Id, groupNumber, newSlabSteelGradeInt);
                }

                casterSequenceItemId = CreateSequenceItem((int)job.HeatPosition + 1, unitSequence.Id, heatGroupId);

                addedSequenceItems.Add(new SequenceItem()
                {
                    Id = casterSequenceItemId,
                    ItemOrder = (int)job.HeatPosition + 1,
                    UnitSequenceId = unitSequence.Id,
                    HeatGroupId = heatGroupId
                });

                AddInputMaterial(Heat.id, casterSequenceItemId, (int)job.HeatPosition + 1);
            }
            else
            {
                casterSequenceItemId = sequenceItem.Id;
            }

            AddOutputMaterial(slabId, casterSequenceItemId, (int)job.SlabPosition + 1);
        }

        private void CreateHSMOptimizedScenario(IEnumerable<UnitSequence> addedUnitSequences, OptimizedScenarioJob job, UnitSequence unitSequence, IEnumerable<dynamic> materialsList)
        {
            int hsmUnitSequenceId = addedUnitSequences.FirstOrDefault(u => u.ProductionUnitType == "HSM").Id;
            int casterUnitSequenceId = unitSequence.Id;
            var piece = materialsList.FirstOrDefault(m => m.PieceId == job.PieceId);

            int slabId = piece.SlabId;
            int coilId = piece.CoilId;

            // Do the interweaving on HSM
            int LastHSMItem = _unitSequenceRepository.GetLastSequenceItemOrder(hsmUnitSequenceId);
            HSMItemWithCasterUnit LastItemOfCaster = _unitSequenceRepository.GetLastItemOfCaster(hsmUnitSequenceId, casterUnitSequenceId);
            HSMItemWithCasterUnit LastItemOfOtherCaster = _unitSequenceRepository.GetLastItemOfDifferentCaster(hsmUnitSequenceId, casterUnitSequenceId);

            int HSMSequenceItemId;
            if (LastItemOfOtherCaster == null)
                HSMSequenceItemId = _unitSequenceService.AddNewSequenceItem(hsmUnitSequenceId, null);
            else if (LastItemOfCaster == null)
            {
                HSMSequenceItemId = _unitSequenceService.AddNewHSMSequenceItemWithPosition(hsmUnitSequenceId, 2);

                if (LastHSMItem > 2)
                {
                    MaterialMovementBody MoveData = new()
                    {
                        MaterialType = "coil",
                        MoveType = "middle",
                        NewPositon = 2,
                        OldPosition = LastHSMItem + 1,
                        SequenceItemId = HSMSequenceItemId,
                    };

                    _materialService.MoveMaterial(MoveData);
                }
            }
            else if (LastItemOfCaster.HSMSequenceItemOrder > LastItemOfOtherCaster.HSMSequenceItemOrder)
            {
                HSMSequenceItemId = _unitSequenceService.AddNewSequenceItem(hsmUnitSequenceId, null);
            }
            else if ((LastItemOfCaster.HSMSequenceItemOrder + 2) <= LastHSMItem)
            {
                HSMSequenceItemId = _unitSequenceService.AddNewHSMSequenceItemWithPosition(hsmUnitSequenceId, (LastItemOfCaster.HSMSequenceItemOrder + 2));

                MaterialMovementBody MoveData = new()
                {
                    MaterialType = "coil",
                    MoveType = "middle",
                    NewPositon = (LastItemOfCaster.HSMSequenceItemOrder + 2),
                    OldPosition = LastHSMItem + 1,
                    SequenceItemId = HSMSequenceItemId,
                };

                _materialService.MoveMaterial(MoveData);
            }
            else
            {
                HSMSequenceItemId = _unitSequenceService.AddNewSequenceItem(hsmUnitSequenceId, null);
            }

            AddInputMaterial(slabId, HSMSequenceItemId, 1);
            AddOutputMaterial(coilId, HSMSequenceItemId, 1);
        }

        private int CreateSequenceItem(int itemOrder, int unitSequence, int? heatGroup)
        {
            var sequenceItem = new SequenceItem()
            {
                ItemOrder = itemOrder,
                UnitSequenceId = unitSequence,
                HeatGroupId = heatGroup
            };
            return _sequenceItemRepository.Add(sequenceItem);
        }

        private void AddInputMaterial(int materialId, int sequenceItemId, int materialOrder)
        {
            var inputMaterial = new InputOutputMaterial()
            {
                MaterialId = materialId,
                SequenceItemId = sequenceItemId,
                MaterialOrder = materialOrder
            };
            _inputMaterialRepository.Add(inputMaterial);
        }

        private void AddOutputMaterial(int materialId, int sequenceItemId, int materialOrder)
        {
            var outputMaterial = new InputOutputMaterial()
            {
                MaterialId = materialId,
                SequenceItemId = sequenceItemId,
                MaterialOrder = materialOrder
            };
            _outputMaterialRepository.Add(outputMaterial);
        }
    }
}
