using System;
using System.Collections.Generic;
using System.Globalization;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;

namespace sms_mes_planning_pss_api.Services
{
    public class UnitSequenceService : IUnitSequenceService
    {
        private readonly IMaterialService _materialService;
        private readonly IUnitSequenceRepository _unitSequenceRepository;
        private readonly ISequenceItemRepository _sequenceItemRepository;
        private readonly IMaterialRepository _materialRepository;
        private readonly ISchedulingRuleViolationRepository _schedulingRuleViolationRepository;
        private readonly IHeatGroupRepository _heatGroupRepository;
        private readonly ISequenceScenarioRepository _sequenceScenarioRepository;

        public UnitSequenceService(
            IMaterialService materialService,
            IUnitSequenceRepository unitSequenceRepository,
            ISequenceItemRepository sequenceItemRepository,
            IMaterialRepository materialRepository,
            ISchedulingRuleViolationRepository schedulingRuleViolationRepository,
            IHeatGroupRepository heatGroupRepository,
            ISequenceScenarioRepository sequenceScenarioRepository
        )
        {
            _materialService = materialService;
            _unitSequenceRepository = unitSequenceRepository;
            _sequenceItemRepository = sequenceItemRepository;
            _materialRepository = materialRepository;
            _schedulingRuleViolationRepository = schedulingRuleViolationRepository;
            _heatGroupRepository = heatGroupRepository;
            _sequenceScenarioRepository = sequenceScenarioRepository;
        }
        public int Add(UnitSequence unitSequence)
        {
            return _unitSequenceRepository.Add(unitSequence);
        }
        public IEnumerable<UnitSequence> GetBySequenceScenarioId(int sequenceScenarionId)
        {
            return _unitSequenceRepository.GetBySequenceScenarioId(sequenceScenarionId);
        }
        public IEnumerable<UnitSequence> GetCastersBySequenceScenarioId(int sequenceScenarionId)
        {
            return _unitSequenceRepository.GetCastersBySequenceScenarioId(sequenceScenarionId);
        }
        public IEnumerable<MaterialHeat> GetHeatListByUnitSequence(int unitSequenceId)
        {
            return _unitSequenceRepository.GetHeatListByUnitSequence(unitSequenceId);
        }
        public int GetNewOutputOrder(int sequenceItemId)
        {
            return _unitSequenceRepository.GetNewOutputOrder(sequenceItemId);
        }
        public bool AddNewMaterial(UnitSequenceNewMaterial[] unitSequenceNewMaterial)
        {
            string newSlabSteelGradeInt;
            int materialId, groupNumber, sequenceItemId = 0, heatGroupId = 0;
            double existingHeatWeight, totalSlabWeightAim = 0;
            bool sameSteelGrade, firstExecution = true, newHeatSameHeatGroup;

            for (int i = 0; i < unitSequenceNewMaterial.Length; i++)
            {
                dynamic SlabInfo = _materialRepository.GetMaterialById(unitSequenceNewMaterial[i].materialId);

                materialId = _materialRepository.GetMaterialIdBySequeceItemId(sequenceItemId);

                //update heat with the full weigth
                if (materialId != 0 && totalSlabWeightAim > 0)
                    _materialRepository.UpdateMaterialHeatWeight(totalSlabWeightAim, materialId);

                if (unitSequenceNewMaterial[i].sequenceItemId == null)
                {
                    if (unitSequenceNewMaterial[i].unitSequenceId == 0) return false;

                    // Obtaining the material info                    
                    newSlabSteelGradeInt = SlabInfo.STEEL_GRADE_INT;
                    sameSteelGrade = false;
                    newHeatSameHeatGroup = false;

                    int lastSequenceItemOrder = _unitSequenceRepository.GetLastSequenceItemOrder(unitSequenceNewMaterial[i].unitSequenceId);

                    if (lastSequenceItemOrder == 0) // When the table is empty
                    {
                        groupNumber = _heatGroupRepository.GetNextGroupNumber();
                        heatGroupId = _heatGroupRepository.Add(unitSequenceNewMaterial[i].unitSequenceId, groupNumber, newSlabSteelGradeInt);
                        sequenceItemId = AddNewSequenceItem(unitSequenceNewMaterial[i].unitSequenceId, heatGroupId);
                    }
                    else
                    {
                        // Get the Heat group from the previous record
                        HeatGroup selectedHeatGroup = _heatGroupRepository.GetHeatGroupById(_sequenceItemRepository.GetHeatGroupIdByItemOrder(lastSequenceItemOrder, unitSequenceNewMaterial[i].unitSequenceId));

                        // if exists compare with the new added slab to verify if their steel grade match
                        if (selectedHeatGroup != null)
                            if (selectedHeatGroup.HeatSteelGradeInt == newSlabSteelGradeInt)
                            {
                                sameSteelGrade = true;
                                heatGroupId = selectedHeatGroup.Id;
                                groupNumber = selectedHeatGroup.GroupNumber;
                            }
                            else
                                groupNumber = _heatGroupRepository.GetNextGroupNumber();
                        else
                            groupNumber = _heatGroupRepository.GetNextGroupNumber();

                        if (!sameSteelGrade)
                        {
                            heatGroupId = _heatGroupRepository.Add(unitSequenceNewMaterial[i].unitSequenceId, groupNumber, newSlabSteelGradeInt);
                            sequenceItemId = AddNewSequenceItem(unitSequenceNewMaterial[i].unitSequenceId, heatGroupId);
                        }
                        else
                        {
                            if (unitSequenceNewMaterial[i].sequenceItemId == null && sequenceItemId == 0)
                            {
                                sequenceItemId = AddNewSequenceItem(unitSequenceNewMaterial[i].unitSequenceId, heatGroupId);
                                newHeatSameHeatGroup = true;
                            }
                        }
                    }

                    unitSequenceNewMaterial[i].sequenceItemId = sequenceItemId;

                    if (sequenceItemId <= 0) return false;

                    if (!sameSteelGrade || newHeatSameHeatGroup)
                    {
                        Material Heat = _materialRepository.AddNewHeat(unitSequenceNewMaterial[i].materialId);
                        _ = _unitSequenceRepository.AddNewInputMaterial(sequenceItemId, Heat.id, 1);
                        totalSlabWeightAim = 0;
                    }
                }
                else if (unitSequenceNewMaterial[i].sequenceItemId != null)
                {
                    sequenceItemId = unitSequenceNewMaterial[i].sequenceItemId.Value;
                    if (firstExecution)
                    {
                        existingHeatWeight = _materialRepository.GetHeatWeightByMaterialId(_materialRepository.GetMaterialIdBySequeceItemId(sequenceItemId));
                        totalSlabWeightAim += existingHeatWeight;
                        firstExecution = false;
                    }
                }

                bool SlabAdded = _unitSequenceRepository.AddNewMaterial(sequenceItemId, unitSequenceNewMaterial[i].materialId, unitSequenceNewMaterial[i].materialOrder);

                if (!SlabAdded) return false;

                UnitSequence HSMUnitSequenceId = _unitSequenceRepository.GetHSMUnitSequenceByCaster(unitSequenceNewMaterial[i].unitSequenceId);

                int LastHSMItem = _unitSequenceRepository.GetLastSequenceItemOrder(HSMUnitSequenceId.Id);
                HSMItemWithCasterUnit LastItemOfCaster = _unitSequenceRepository.GetLastItemOfCaster(HSMUnitSequenceId.Id, unitSequenceNewMaterial[i].unitSequenceId);
                HSMItemWithCasterUnit LastItemOfOtherCaster = _unitSequenceRepository.GetLastItemOfDifferentCaster(HSMUnitSequenceId.Id, unitSequenceNewMaterial[i].unitSequenceId);

                int HSMSequenceItemId;
                if (LastItemOfOtherCaster == null)
                    HSMSequenceItemId = AddNewSequenceItem(HSMUnitSequenceId.Id, null);
                else if (LastItemOfCaster == null)
                {
                    HSMSequenceItemId = AddNewHSMSequenceItemWithPosition(HSMUnitSequenceId.Id, 2);

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
                    HSMSequenceItemId = AddNewSequenceItem(HSMUnitSequenceId.Id, null);
                }
                else if ((LastItemOfCaster.HSMSequenceItemOrder + 2) <= LastHSMItem)
                {
                    HSMSequenceItemId = AddNewHSMSequenceItemWithPosition(HSMUnitSequenceId.Id, (LastItemOfCaster.HSMSequenceItemOrder + 2));

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
                    HSMSequenceItemId = AddNewSequenceItem(HSMUnitSequenceId.Id, null);
                }

                if (HSMSequenceItemId <= 0) return false;

                int CoilId = _materialRepository.GetRelatedCoil(SlabInfo.PS_PIECE_ID);
                totalSlabWeightAim += double.Parse(SlabInfo.SLAB_WEIGHT_AIM, CultureInfo.InvariantCulture.NumberFormat);

                if (CoilId <= 0) return false;

                bool NewHSMInputMaterial = _unitSequenceRepository.AddNewInputMaterial(HSMSequenceItemId, unitSequenceNewMaterial[i].materialId, 1);

                if (!NewHSMInputMaterial) return false;

                bool NewHSMOutputMaterial = _unitSequenceRepository.AddNewMaterial(HSMSequenceItemId, CoilId, 1);

                if (!NewHSMOutputMaterial) return false;

            }

            materialId = _materialRepository.GetMaterialIdBySequeceItemId(sequenceItemId);

            //update the last record of the loop
            if (materialId != 0)
                _materialRepository.UpdateMaterialHeatWeight(totalSlabWeightAim, materialId);

            SequenceScenario scenario = _sequenceScenarioRepository.GetBySequenceItemId(sequenceItemId);
            _schedulingRuleViolationRepository.CheckViolationByScenarioId(scenario.Id);

            return true;
        }
        public IEnumerable<dynamic> GetCasterMaterialList(int unitSequenceId)
        {
            return _unitSequenceRepository.GetCasterMaterialList(unitSequenceId);
        }
        public IEnumerable<dynamic> GetHSMMaterialList(int unitSequenceId)
        {
            return _unitSequenceRepository.GetHSMMaterialList(unitSequenceId);
        }
        public UnitSequenceAttributesSum GetSumOfAttributes(string unitSequenceName, int scenarioId)
        {
            try
            {
                UnitSequenceAttributesSum sumOfAttributes = _unitSequenceRepository.GetSumOfAttributes(unitSequenceName, scenarioId);

                return sumOfAttributes;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw new Exception(e.ToString());
            }
        }
        public int AddNewSequenceItem(int unitSequenceId, int? heatGroupId)
        {
            int NewOrder = _unitSequenceRepository.GetNewSequenceItemOrder(unitSequenceId);

            SequenceItem sequenceItem = new()
            {
                ItemOrder = NewOrder,
                UnitSequenceId = unitSequenceId,
                HeatGroupId = heatGroupId
            };

            return _sequenceItemRepository.Add(sequenceItem);
        }
        public int AddNewHSMSequenceItemWithPosition(int unitSequenceId, int order)
        {
            SequenceItem sequenceItem = new()
            {
                ItemOrder = order,
                UnitSequenceId = unitSequenceId,
                HeatGroupId = null
            };

            return _sequenceItemRepository.Add(sequenceItem);
        }
    }
}
