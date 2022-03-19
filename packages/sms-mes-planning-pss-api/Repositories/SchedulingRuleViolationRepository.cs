using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using Jint;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class SchedulingRuleViolationRepository : ISchedulingRuleViolationRepository
    {
        private readonly IBaseRepository _baseRepository;
        private readonly IMaterialRepository _materialRepository;
        private readonly ISequenceItemRepository _sequenceItemRepository;
        private readonly IUnitSequenceRepository _unitSequenceRepository;
        private readonly ITransitionRepository _transitionRepository;
        private readonly IMaterialAttributeDefinitionRepository _materialAttributeDefinitionRepository;        
        public SchedulingRuleViolationRepository(
            IBaseRepository baseRepositor,
            IMaterialRepository materialRepository,
            ISequenceItemRepository sequenceItemRepository,
            IUnitSequenceRepository unitSequenceRepository,
            ITransitionRepository transitionRepository,
            IMaterialAttributeDefinitionRepository materialAttributeDefinitionRepository
        )
        {
            _baseRepository = baseRepositor;
            _materialRepository = materialRepository;
            _sequenceItemRepository = sequenceItemRepository;
            _unitSequenceRepository = unitSequenceRepository;
            _transitionRepository = transitionRepository;
            _materialAttributeDefinitionRepository = materialAttributeDefinitionRepository;
        }        
        
        public bool CheckViolationByScenarioId(int sequenceScenarioId)
        {
            //TODO: Apply this function to all the places that it's needed
            var param = new { sequenceScenarioId };
            var unitSequenceList = _baseRepository.GetQueryResult<UnitSequence>(UnitSequenceQuery.GetBySequenceScenarioId, param);

            foreach (var unitSequence in unitSequenceList)
            {
                switch (unitSequence.ProductionUnitType)
                {
                    case "Caster":
                        IEnumerable<SchedulingRule> CasterInputImplementations = _baseRepository.GetQueryResult<SchedulingRule>(
                            SchedulingRuleViolationQuery.GetImplementationForInputMaterial,
                            new { unitSequenceId = unitSequence.Id }
                        );
                        IEnumerable<SchedulingRule> CasterOutputImplementations = _baseRepository.GetQueryResult<SchedulingRule>(
                            SchedulingRuleViolationQuery.GetImplementationForOutputMaterial,
                            new { unitSequenceId = unitSequence.Id }
                        );

                        List<ExpandoObject> CasterInputMaterialsList = _unitSequenceRepository.GetInputMaterialList(unitSequence.Id);
                        this.CheckIfHasAnyViolation(CasterInputMaterialsList, CasterInputImplementations);

                        List<ExpandoObject> CasterOutputMaterialsList = _unitSequenceRepository.GetOutputMaterialList(unitSequence.Id);
                        this.CheckIfHasAnyViolation(CasterOutputMaterialsList, CasterOutputImplementations);
                        break;

                    case "HSM":
                        IEnumerable<SchedulingRule> HSMOutputImplementations = _baseRepository.GetQueryResult<SchedulingRule>(
                            SchedulingRuleViolationQuery.GetImplementationForOutputMaterial,
                            new { unitSequenceId = unitSequence.Id }
                        );

                        List<ExpandoObject> HSMOutputMaterialsList = _unitSequenceRepository.GetOutputMaterialList(unitSequence.Id);
                        this.CheckIfHasAnyViolation(HSMOutputMaterialsList, HSMOutputImplementations);
                        break;

                    default:
                        break;
                }
            }
            return true;
        }
        public IEnumerable<SchedulingRuleViolation> GetComboBySequenceItem(int MaterialId, int SequenceItemId)
        {
            try
            {
                string MaterialPosition = this.MountPosition(MaterialId, SequenceItemId);

                return _baseRepository.GetQueryResult<SchedulingRuleViolation>(
                    SchedulingRuleViolationQuery.GetComboBySequenceItem,
                    new { sequenceItemId = SequenceItemId, position = MaterialPosition }
                );
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public bool AcceptRuleViolation(SchedulingRuleViolationAcceptance RuleViolationAccept)
        {
            try
            {
                var parameters = new
                {
                    responsible = RuleViolationAccept.Responsible,
                    schedulingRuleViolationId = RuleViolationAccept.SchedulingRuleViolationId
                };

                _baseRepository.RunQuery(SchedulingRuleViolationQuery.InsertRuleViolationSuppression, parameters);
                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public IEnumerable<MaterialRuleViolation> GetViolationForMaterial(int SequenceItemId, string Position)
        {
            var parameters = new
            {
                sequenceItemId = SequenceItemId,
                position = Position
            };

            IEnumerable<MaterialRuleViolation> materialRuleViolation = _baseRepository
                .GetQueryResult<string>(SchedulingRuleViolationQuery.GetViolationForMaterial, parameters)
                .Select(ruleViolation => JsonConvert.DeserializeObject<MaterialRuleViolation>(ruleViolation, new ExpandoObjectConverter()))
                .ToArray();

            return materialRuleViolation;
        }
        private void CheckIfHasAnyViolation(List<ExpandoObject> MaterialsList, IEnumerable<SchedulingRule> ViolationRuleList)
        {
            try
            {
                //Instaciate the Validator Function as d Delegate to be used inside the Jint Engine
                Func<string, string, string> validateSlabGradeTransition = this.ValidateSlabSteelGradeTransition;

                //Navigate the List to verify if have any Rule Violation
                for (int i = 0; i < (MaterialsList.Count - 1); i++)
                {
                    dynamic CurrentMaterial = MaterialsList[i];
                    dynamic NextMaterial = MaterialsList[i + 1];

                    dynamic MaterialObject = new
                    {
                        currentLine = CurrentMaterial,
                        nextLine = NextMaterial
                    };

                    foreach (SchedulingRule violatioRule in ViolationRuleList)
                    {
                        var schedulingRule = new Engine()
                            .SetValue("ValidateSlabGradeTransition", validateSlabGradeTransition)
                            .Execute(violatioRule.ImplementationTranspiled)
                            .Invoke("schedulingRule", MaterialObject);

                        Console.WriteLine("Scheduling Rule Result: " + schedulingRule.AsBoolean());

                        if (schedulingRule.AsBoolean())
                        {
                            //TODO: Verify a way to solve the Material Position problem, to have a better way to localize the correct Material Line with error
                            string matId = Convert.ToString(CurrentMaterial.material_id);
                            string seqItemId = Convert.ToString(CurrentMaterial.sequenceItemId);
                            string MaterialPosition = this.MountPosition(Int32.Parse(matId), Int32.Parse(seqItemId));

                            //Delete previous records to reprocess
                            _baseRepository.RunQuery(
                                SchedulingRuleViolationQuery.DeleteSchedulingRuleViolation,
                                new
                                {
                                    sequenceItemId = Int32.Parse(CurrentMaterial.sequenceItemId),
                                    schedulingRuleId = violatioRule.Id,
                                    position = MaterialPosition
                                }
                            );

                            //Insert Violation Rule
                            _baseRepository.RunQuery(
                                SchedulingRuleViolationQuery.InsertSchedulingRuleViolation,
                                new
                                {
                                    schedulingRuleId = violatioRule.Id,
                                    sequenceItemId = Int32.Parse(CurrentMaterial.sequenceItemId),
                                    currentMaterialPos = MaterialPosition,
                                }
                            );
                        }
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }
        private string MountPosition(int MaterialId, int SequenceItemId)
        {
            try
            {
                RemoveMaterial MaterialData = new RemoveMaterial
                {
                    MaterialId = MaterialId,
                    SequenceItemId = SequenceItemId
                };

                dynamic MaterialUsage = _materialRepository.CheckMaterialUsage(MaterialData);
                SequenceItem SequenceItemData = _baseRepository.GetQueryResult<SequenceItem>(
                    SequenceItemQuery.GetById,
                    new { sequenceItemId = MaterialUsage.material.SequenceItemId }
                ).SingleOrDefault();

                ProductionUnit ProductionUnitType = _sequenceItemRepository.GetUnitTypeBySequenceItem(MaterialUsage.material.SequenceItemId);

                if (ProductionUnitType.Type == "Caster")
                {
                    if (MaterialUsage.usage == "Output")
                    {
                        return string.Concat(SequenceItemData.ItemOrder, ".", MaterialUsage.material.ItemOrder);
                    }
                }

                return SequenceItemData.ItemOrder.ToString();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
        }
        public string ValidateSlabSteelGradeTransition(string From, string To)
        {
            MaterialAttributeDefinition currentAttributeDefiniton = _materialAttributeDefinitionRepository.GetByMaterialTypeAndAttributeName("STEEL_GRADE_INT", "Slab");
            var parameter = new NewTransition
            {
                Attribute = currentAttributeDefiniton.Id,
                From = From,
                To = To,
            }; 

            Transition searchedTransition = _transitionRepository.GetTransitionByData(parameter);

            if (searchedTransition != default)
            {
                return searchedTransition.Classification;
            } else {
                return "";
            }
        }
    }
}
