using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;
using sms_mes_planning_pss_api.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace sms_mes_planning_pss_api.Services
{
    public class MaterialService : IMaterialService
    {
        private readonly IPlanningHorizonService _planningHorizonService;
        private readonly IMaterialRepository _materialRepository;
        private readonly IMaterialFilterService _materialFilterService;
        private readonly ISequenceItemRepository _sequenceItemRepository;
        private readonly ISequenceScenarioRepository _sequenceScenarioRepository;
        private readonly ISchedulingRuleViolationRepository _schedulingRuleViolationRepository;
        private readonly IBaseRepository _baseRepository;        

        public MaterialService(
            IMaterialRepository materialRepository, 
            IPlanningHorizonService planningHorizonService, 
            IMaterialFilterService materialFilterService, 
            ISequenceItemRepository sequenceItemRepository,
            ISequenceScenarioRepository sequenceScenarioRepository,
            ISchedulingRuleViolationRepository schedulingRuleViolationRepository,
            IBaseRepository baseRepository
        )
        {
            _materialRepository = materialRepository;
            _planningHorizonService = planningHorizonService;
            _materialFilterService = materialFilterService;
            _sequenceItemRepository = sequenceItemRepository;
            _sequenceScenarioRepository = sequenceScenarioRepository;
            _schedulingRuleViolationRepository = schedulingRuleViolationRepository;
            _baseRepository = baseRepository;
        }

        public IEnumerable<dynamic> GetAvailableMaterialsToAdd(int? productionUnitId, int sequenceScenarioId, int groupSequenceId, int? materialFilterId, int? planningHorizonId)
        {
            var phFilter = "";

            if (planningHorizonId != null)
            {
                phFilter = _planningHorizonService.ConvertToQuery(planningHorizonId.Value);
            }

            IEnumerable<dynamic> materialResults = _materialRepository.GetAvailableMaterialsToAdd(productionUnitId, sequenceScenarioId, groupSequenceId, phFilter);

            if (materialFilterId != null)
            {
                materialResults = _materialFilterService.GetFilteredMaterialsList(materialFilterId.Value, materialResults);
            }

            return materialResults;
        }

        public IEnumerable<dynamic> GetMaterialsGroupedByPieceId(int sequenceScenarioId, int groupSequenceId, int? materialFilterId, int? planningHorizonId)
        {
            IEnumerable<string> pieceIdList = GetAvailableMaterialsToAdd(null, sequenceScenarioId, groupSequenceId, materialFilterId, planningHorizonId)
                .Select(m => (string)((IDictionary<string, object>)m)["11"]); //obtain the piece id list (11)

            return _materialRepository.GetMaterialsGroupedByPieceId(pieceIdList);
        }

        public bool MoveMaterial(MaterialMovementBody materialMovementBody)
        {
            SequenceScenario Scenario = _sequenceScenarioRepository.GetBySequenceItemId(materialMovementBody.SequenceItemId);
            switch (materialMovementBody.MoveType)
            {
                case "first":
                    bool isFirstMoved = this.MoveToFirst(materialMovementBody);

                    if (!isFirstMoved)
                    {
                        return false;
                    }

                    _schedulingRuleViolationRepository.CheckViolationByScenarioId(Scenario.Id);

                    return true;

                case "last":
                    bool isLastMoved = this.MoveToLast(materialMovementBody);

                    if (!isLastMoved)
                    {
                        return false;
                    }

                    _schedulingRuleViolationRepository.CheckViolationByScenarioId(Scenario.Id);

                    return true;

                default:
                    bool isDefaultMoved = this.MoveToMiddle(materialMovementBody);

                    if (!isDefaultMoved)
                    {
                        return false;
                    }

                    _schedulingRuleViolationRepository.CheckViolationByScenarioId(Scenario.Id);

                    return true;
            }
        }

        private bool MoveToFirst(MaterialMovementBody materialMovementBody)
        {
            switch (materialMovementBody.MaterialType)
            {
                case "heat":
                    return _materialRepository.MoveToFirst(materialMovementBody);

                case "coil":
                    return _materialRepository.MoveToFirst(materialMovementBody);

                default:
                    if (materialMovementBody.OldSequenceItemId == 0)
                    {
                        return _materialRepository.MoveOutputToFirstOnSameItem(materialMovementBody);
                    }
                    else
                    {
                        return _materialRepository.MoveOutputToFirstOnDifferentItem(materialMovementBody);
                    }
            }
        }

        private bool MoveToLast(MaterialMovementBody materialMovementBody)
        {
            switch (materialMovementBody.MaterialType)
            {
                case "heat":
                    return _materialRepository.MoveToLast(materialMovementBody);

                case "coil":
                    return _materialRepository.MoveToLast(materialMovementBody);

                default:
                    if (materialMovementBody.OldSequenceItemId == 0)
                    {
                        return _materialRepository.MoveOutputToLastOnSameItem(materialMovementBody);
                    }
                    else
                    {
                        return _materialRepository.MoveOutputToLastOnDifferentItem(materialMovementBody);
                    }
            }
        }

        private bool MoveToMiddle(MaterialMovementBody materialMovementBody)
        {
            switch (materialMovementBody.MaterialType)
            {
                case "heat":
                    return _materialRepository.MoveToMiddle(materialMovementBody);

                case "coil":
                    return _materialRepository.MoveToMiddle(materialMovementBody);

                default:
                    if (materialMovementBody.OldSequenceItemId == 0)
                    {
                        return _materialRepository.MoveOutputToMiddleOnSameItem(materialMovementBody);
                    }
                    else
                    {
                        return _materialRepository.MoveOutputToMiddleOnDifferentItem(materialMovementBody);
                    }
            }
        }

        public bool RemoveFromUnit(RemoveMaterial materialData)
        {
            int heatMaterialId = 0;
            double existingHeatWeight, slabWeightAimDeleted = 0;

            try
            {
                dynamic material = _materialRepository.CheckMaterialUsage(materialData);
                dynamic SlabInfo = _materialRepository.GetMaterialById(materialData.MaterialId);

                if (material.usage == "Output")
                {
                    ProductionUnit materialUnit = _sequenceItemRepository.GetUnitTypeBySequenceItem(materialData.SequenceItemId);
                    
                    if (materialUnit.Type == "Caster")
                    {
                        heatMaterialId = _materialRepository.GetMaterialIdBySequeceItemId(materialData.SequenceItemId);
                        existingHeatWeight = _materialRepository.GetHeatWeightByMaterialId(heatMaterialId);
                        slabWeightAimDeleted = existingHeatWeight - double.Parse(SlabInfo.SLAB_WEIGHT_AIM, CultureInfo.InvariantCulture.NumberFormat);

                        _materialRepository.RemoveSlab(materialData);                        
                    }
                    else if (materialUnit.Type == "HSM")
                    {
                        MaterialOutput casterMaterialOutput = _baseRepository.GetQueryResult<MaterialOutput>(MaterialQuery.CasterSlabByCoilSequenceItem, new { sequenceItemId = materialData.SequenceItemId}).SingleOrDefault();

                        heatMaterialId = _materialRepository.GetMaterialIdBySequeceItemId(casterMaterialOutput.MaterialId);
                        existingHeatWeight = _materialRepository.GetHeatWeightByMaterialId(heatMaterialId);
                        slabWeightAimDeleted = existingHeatWeight - double.Parse(SlabInfo.SLAB_WEIGHT_AIM, CultureInfo.InvariantCulture.NumberFormat);

                        _materialRepository.RemoveCoil(materialData);
                    }

                    if (slabWeightAimDeleted > 0)
                        _materialRepository.UpdateMaterialHeatWeight(slabWeightAimDeleted, heatMaterialId);
                }
                else
                {
                    _materialRepository.RemoveSequenceItemWithMaterials(materialData);
                }

                _schedulingRuleViolationRepository.CheckViolationByScenarioId(materialData.SequenceScenarioId);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
    }
}
