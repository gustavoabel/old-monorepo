using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using RestSharp;

namespace sms_mes_planning_pss_api.Services
{
    public class GroupSequenceService : IGroupSequenceService
    {
        private readonly IConfiguration _configuration;
        private readonly IMaterialRepository _materialRepository;
        private readonly IGroupSequenceRepository _groupSequenceRepository;
        private readonly ISequenceScenarioService _sequenceScenarioService;
        private readonly IUnitSequenceService _unitSequenceService;
        private readonly ISequenceScenarioRepository _sequenceScenarioRepository;
        private readonly ISmsIntegrationBaseRepository _mesIntegration;
        private string _token;

        public GroupSequenceService(
            IConfiguration configuration,
            IMaterialRepository materialRepository,
            IGroupSequenceRepository groupSequenceRepository,
            IUnitSequenceService unitSequenceService,
            ISequenceScenarioService sequenceScenarioService,
            ISequenceScenarioRepository sequenceScenarioRepository)
        {
            _configuration = configuration;
            _groupSequenceRepository = groupSequenceRepository;
            _sequenceScenarioService = sequenceScenarioService;
            _unitSequenceService = unitSequenceService;
            _sequenceScenarioRepository = sequenceScenarioRepository;
            _materialRepository = materialRepository;
            _mesIntegration = new SmsIntegrationBaseRepository("MES", configuration);
        }

        public int Add(GroupSequence groupSequence)
        {
            ValidateGroupSequence(groupSequence);
            groupSequence.PlanningStatus = "PLANNING";
            groupSequence.ExecutionStatus = "NOT STARTED";
            int groupSequenceId = _groupSequenceRepository.Add(groupSequence);
            ConcurrentBag<SequenceScenario> concurrentSequenceScenarioList = new ConcurrentBag<SequenceScenario>(groupSequence.ScenarioList);
            CreateSequenceScenariosAndVersions(concurrentSequenceScenarioList, groupSequenceId);
            return groupSequenceId;
        }

        public void Update(GroupSequence groupSequence)
        {
            groupSequence.ScenarioList = _sequenceScenarioService.GetByGroupSequenceId(groupSequence.Id);
            ValidateGroupSequence(groupSequence);
            _groupSequenceRepository.Update(groupSequence);
            UpdateSequenceScenarios(groupSequence.ScenarioList, groupSequence.Id);
        }

        public void Delete(int groupSequenceId)
        {
            _groupSequenceRepository.Delete(groupSequenceId);
            DeleteSequenceScenarioList(groupSequenceId);
        }

        public IEnumerable<GroupSequence> GetAll()
        {
            return _groupSequenceRepository.GetAll();
        }

        public GroupSequence GetById(int groupSequenceId)
        {
            return _groupSequenceRepository.GetById(groupSequenceId);
        }
        public GroupSequence GetSequenceByScenarioId(int scenarioId)
        {
            return _groupSequenceRepository.GetSequenceByScenarioId(scenarioId);
        }

        public bool BookGroupSequence(int groupSequenceId, int sequenceScenarioId)
        {
            bool isBooked = _groupSequenceRepository.ChangePlanningStatus(groupSequenceId, "BOOKED");

            if (isBooked)
            {
                bool isSelected = _sequenceScenarioRepository.SelectActualSequenceScenario(sequenceScenarioId, groupSequenceId);

                if (isSelected)
                {
                    return true;
                }

                _groupSequenceRepository.ChangePlanningStatus(groupSequenceId, "PLANNING");
                return false;
            }

            return false;
        }

        private void ValidateGroupSequence(GroupSequence groupSequence)
        {
            if (!IsGroupSequenceValid(groupSequence))
                throw new BadHttpRequestException("Please fill all the mandatory fields");

            if (!IsSequenceScenarioListUnique(groupSequence.ScenarioList))
                throw new BadHttpRequestException("The combination of sequence scenarios should be unique");
        }

        private void CreateSequenceScenariosAndVersions(ConcurrentBag<SequenceScenario> concurrentSequenceScenarioList, int groupSequenceId)
        {
            Parallel.ForEach(
                concurrentSequenceScenarioList,
                new ParallelOptions()
                {
                    MaxDegreeOfParallelism = 10
                },
                (sequenceScenario) => CreateNewSequenceScenario(sequenceScenario, groupSequenceId)
            );
        }

        private void UpdateSequenceScenarios(IEnumerable<SequenceScenario> sequenceScenarioList, int groupSequenceId)
        {
            foreach (var sequenceScenario in sequenceScenarioList)
            {
                sequenceScenario.GroupSequenceId = groupSequenceId;
                _sequenceScenarioService.Update(sequenceScenario);
            }
        }

        private int CreateNewSequenceScenario(SequenceScenario sequenceScenario, int groupSequenceId)
        {
            SequenceScenario newSequenceScenario = new SequenceScenario()
            {
                Name = sequenceScenario.Name,
                Rating = sequenceScenario.Rating,
                GroupSequenceId = groupSequenceId,
                MaterialFilterId = sequenceScenario.MaterialFilterId,
                PlanningHorizonId = sequenceScenario.PlanningHorizonId,                
                UseOptimizer = sequenceScenario.UseOptimizer
            };
            return _sequenceScenarioService.Add(newSequenceScenario);
        }

        private void DeleteSequenceScenarioList(int groupSequenceId)
        {
            IEnumerable<SequenceScenario> sequenceScenarioList = _sequenceScenarioService.GetByGroupSequenceId(groupSequenceId);
            foreach (var sequenceScenario in sequenceScenarioList)
            {
                _sequenceScenarioService.Delete(sequenceScenario.Id);
            }
        }

        private bool IsGroupSequenceValid(GroupSequence groupSequence)
        {
            return !string.IsNullOrEmpty(groupSequence.Name)
                && groupSequence.ScenarioList != null
                && groupSequence.ScenarioList.Any();
        }

        private bool IsSequenceScenarioListUnique(IEnumerable<SequenceScenario> sequenceScenarioList)
        {
            return sequenceScenarioList.GroupBy(s => new
            {
                s.MaterialFilterId,
                s.PlanningHorizonId
            }).Count() == sequenceScenarioList.Count();
        }

        public bool SaveSequencesMes(int groupSequenceId)
        {
            bool isAuthenticated = Authenticate();

            if (isAuthenticated)
            {
                string jsonRequest;
                bool savedInMes = false;
                int countMaterial, sequenceScenarioId;
                SendToMesJson sendToMesJson = new();
                MesProgramAtrib mesProgramAtrib = new();
                IEnumerable<dynamic> casters, heatProgramLine;

                SendToMES mesProgram;
                sequenceScenarioId = _sequenceScenarioRepository.GetSelectedSequenceScenario(groupSequenceId);
                casters = _unitSequenceService.GetCastersBySequenceScenarioId(sequenceScenarioId);

                foreach (UnitSequence unitCaster in casters)
                {
                    mesProgram = _groupSequenceRepository.GetMesProgram(groupSequenceId, unitCaster.SequenceScenarioVersionId, unitCaster.ProductionUnitId);

                    if (mesProgram != null)
                    {
                        mesProgramAtrib.PRODUCTION_UNIT_NAME = unitCaster.ProductionUnitName;
                        mesProgramAtrib.START_DATE = mesProgram.StartDate;
                        mesProgramAtrib.DURATION = mesProgram.Duration;
                        mesProgramAtrib.REMARK = mesProgram.Remark;

                        heatProgramLine = _unitSequenceService.GetHeatListByUnitSequence(unitCaster.Id);

                        List<MesProgramLineAtrib> listProgramLine = new();
                        List<MesProgramLineItemAtrib> listProgramLineItem = new();

                        foreach (MaterialHeat heatMaterial in heatProgramLine)
                        {
                            // Feed the Program Line List
                            MesProgramLineAtrib mesProgramLineAtrib = new();
                            countMaterial = 0;

                            mesProgramLineAtrib.PROGRAM_LINE_LEVEL1 = 1;
                            mesProgramLineAtrib.PROGRAM_LINE_LEVEL2 = heatMaterial.sequenceItemOrder;
                            mesProgramLineAtrib.PRODUCTION_UNIT_NAME = unitCaster.ProductionUnitName;
                            mesProgramLineAtrib.PRODUCTION_ORDER_ID = "080818"; //TDB
                            mesProgramLineAtrib.PRODUCTION_STEP_ID = "2";//TDB
                            mesProgramLineAtrib.DURATION = _groupSequenceRepository.GetDurationProgramLine(groupSequenceId, unitCaster.SequenceScenarioVersionId, unitCaster.ProductionUnitId);
                            mesProgramLineAtrib.HEAT_WEIGHT = heatMaterial.heatWeight;
                            mesProgramLineAtrib.TREATMENT_NO = 0;
                            mesProgramLineAtrib.REMARK = "string";
                            mesProgramLineAtrib.STEEL_GRADE_INT = heatMaterial.steelGradeInt;
                            mesProgramLineAtrib.HEAT_GROUP = heatMaterial.groupNumber;

                            listProgramLine.Add(mesProgramLineAtrib);

                            IEnumerable<int> materialsId = _materialRepository.GetOutputMaterialBySequenceItemId(heatMaterial.sequenceItemId);
                            IEnumerable<dynamic> materialsAtrib = _materialRepository.GetMaterialsSendToMES(materialsId);

                            foreach (var item in materialsAtrib)
                            {
                                MesProgramLineItemAtrib mesProgramLineItemAtrib = new();
                                IDictionary<string, object> propertyValues = item;

                                MaterialsMES materialItens = JsonConvert.DeserializeObject<MaterialsMES>(propertyValues["data"].ToString());

                                // Feed the Program Line Item List
                                mesProgramLineItemAtrib.PROGRAM_LINE_LEVEL1 = 1;
                                mesProgramLineItemAtrib.PROGRAM_LINE_LEVEL2 = heatMaterial.sequenceItemOrder;
                                mesProgramLineItemAtrib.PROGRAM_LINE_OUTPUT = _materialRepository.GetMaterialOrderSendToMES(heatMaterial.sequenceItemId, materialsId.ElementAt(countMaterial));
                                mesProgramLineItemAtrib.PRODUCTION_UNIT_NAME = unitCaster.ProductionUnitName;
                                mesProgramLineItemAtrib.PRODUCTION_ORDER_ID = String.IsNullOrEmpty(materialItens.PRODUCTION_ORDER_ID_TARGET) ? "0" : materialItens.PRODUCTION_ORDER_ID_TARGET;
                                mesProgramLineItemAtrib.PRODUCTION_STEP_ID = String.IsNullOrEmpty(materialItens.PRODUCTION_STEP_ID_TARGET) ? "0" : materialItens.PRODUCTION_STEP_ID_TARGET;
                                mesProgramLineItemAtrib.COIL_THICKNESS_AIM = String.IsNullOrEmpty(materialItens.THICKNESS_TARGET) ? "0" : materialItens.THICKNESS_TARGET;
                                mesProgramLineItemAtrib.COIL_WIDTH_AIM = String.IsNullOrEmpty(materialItens.WIDTH_TARGET) ? "0" : materialItens.WIDTH_TARGET;
                                mesProgramLineItemAtrib.COIL_LENGTH_AIM = String.IsNullOrEmpty(materialItens.LENGTH_TARGET) ? "0" : materialItens.LENGTH_TARGET;
                                mesProgramLineItemAtrib.COIL_WEIGHT_AIM = String.IsNullOrEmpty(materialItens.WEIGHT_TARGET) ? "0" : materialItens.WEIGHT_TARGET;
                                mesProgramLineItemAtrib.DURATION = String.IsNullOrEmpty(materialItens.DURATION) ? "0" : materialItens.DURATION;
                                mesProgramLineItemAtrib.REMARK = String.IsNullOrEmpty(materialItens.REMARK) ? "0" : materialItens.REMARK;
                                mesProgramLineItemAtrib.COIL_THICKNESS_AIM = String.IsNullOrEmpty(materialItens.SLAB_THICKNESS_TARGET) ? "0" : materialItens.SLAB_THICKNESS_TARGET;
                                mesProgramLineItemAtrib.TRANSITION_FLAG = 0;
                                mesProgramLineItemAtrib.STEEL_DESIGN_CD = String.IsNullOrEmpty(materialItens.STEEL_DESIGN_CD) ? "0" : materialItens.STEEL_DESIGN_CD;
                                mesProgramLineItemAtrib.OVERPRODUCTION_FLAG = 0;
                                mesProgramLineItemAtrib.SLAB_WIDTH_AIM = String.IsNullOrEmpty(materialItens.SLAB_WIDTH) ? "0" : materialItens.SLAB_WIDTH;
                                mesProgramLineItemAtrib.STEEL_GRADE_INT = String.IsNullOrEmpty(materialItens.STEEL_GRADE_INT) ? "0" : materialItens.STEEL_GRADE_INT;

                                countMaterial++;
                                listProgramLineItem.Add(mesProgramLineItemAtrib);
                            }
                        }
                        sendToMesJson.MesProgram = mesProgramAtrib;
                        sendToMesJson.MesProgramLine = listProgramLine;
                        sendToMesJson.MesProgramLineItem = listProgramLineItem;

                        jsonRequest = JsonConvert.SerializeObject(sendToMesJson);

                        IRestResponse requestReturn = SaveSequenceToMesRequest(jsonRequest);

                        if (!requestReturn.IsSuccessful)
                            return false;
                        else
                            savedInMes = true;
                    }
                }

                if (savedInMes)
                {
                    _ = _groupSequenceRepository.ChangePlanningStatus(groupSequenceId, "SENT TO MES");
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }

        private dynamic SaveSequenceToMesRequest(string body)
        {
            try
            {
                return _mesIntegration.PutJsonBody(body, _token);
            }
            catch (Exception)
            {
                throw new BadHttpRequestException($"It was not possible to save the sequence in the MES.");
            }
        }

        private bool Authenticate()
        {
            try
            {
                var MESValues = _configuration.GetSection("MES_Auth");

                object body = new
                {
                    username = MESValues.GetValue<string>("Username"),
                    password = MESValues.GetValue<string>("Password")
                };

                SmsMaterialIntegrationAuth Auth = _mesIntegration.Post<SmsMaterialIntegrationAuth>("/authenticate", body);

                if (Auth == null)
                    throw new Exception("Error to authenticate");

                _token = Auth.token;

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                return false;
            }
        }
    }
}
