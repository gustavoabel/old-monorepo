using Microsoft.AspNetCore.Http;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;

namespace sms_mes_planning_pss_api.Services
{
    public class SequenceScenarioService : ISequenceScenarioService
    {
        private readonly ISequenceScenarioRepository _sequenceScenarioRepository;
        private readonly ISequenceScenarioVersionService _sequenceScenarioVersionService;
        private readonly IUnitSequenceService _unitSequenceService;
        private readonly IGroupSequenceRepository _groupSequenceRepository;
        private readonly IProductionUnitService _productionUnitService;
        private readonly IOptimizerService _optimizerService;
        private readonly ISchedulingRuleViolationRepository _schedulingRuleViolationRepository;

        public SequenceScenarioService(ISequenceScenarioRepository sequenceScenarioRepository,
            ISequenceScenarioVersionService sequenceScenarioVersionService,
            IUnitSequenceService unitSequenceService,
            IGroupSequenceRepository groupSequenceRepository,
            IProductionUnitService productionUnitService,
            IOptimizerService optimizerService,
            ISchedulingRuleViolationRepository schedulingRuleViolationRepository)
        {
            _sequenceScenarioRepository = sequenceScenarioRepository;
            _sequenceScenarioVersionService = sequenceScenarioVersionService;
            _unitSequenceService = unitSequenceService;
            _groupSequenceRepository = groupSequenceRepository;
            _productionUnitService = productionUnitService;
            _optimizerService = optimizerService;
            _schedulingRuleViolationRepository = schedulingRuleViolationRepository;
        }
        public int Add(SequenceScenario sequenceScenario)
        {
            var addedUnitSequences = new List<UnitSequence>();
            GroupSequence groupSequence = _groupSequenceRepository.GetById(sequenceScenario.GroupSequenceId);

            ValidateAddSequenceScenario(sequenceScenario, groupSequence);

            IEnumerable<ProductionUnit> productionUnitList = _productionUnitService.GetByProductionUnitGroupId(groupSequence.ProductionUnitGroupId);

            int sequenceScenarioId = _sequenceScenarioRepository.Add(sequenceScenario);
            int sequenceScenarioVersionId = CreateNewSequenceScenarioVersion(sequenceScenarioId);

            foreach (var productionUnit in productionUnitList)
            {
                int unitSequenceId = CreateUnitSequence(productionUnit.Id, sequenceScenarioVersionId);

                addedUnitSequences.Add(
                    new UnitSequence() 
                    { 
                        Id = unitSequenceId,
                        ProductionUnitId = productionUnit.Id,
                        ProductionUnitType = productionUnit.Type
                    }
                );
            }

            return sequenceScenarioId;
        }

        public void Update(SequenceScenario sequenceScenario)
        {
            GroupSequence groupSequence = _groupSequenceRepository.GetById(sequenceScenario.GroupSequenceId);
            ValidateUpdateSequenceScenario(sequenceScenario, groupSequence);
            _sequenceScenarioRepository.Update(sequenceScenario);
        }

        public IEnumerable<SequenceScenario> GetByGroupSequenceId(int? groupSequenceId)
        {
            return _sequenceScenarioRepository.GetByGroupSequenceId(groupSequenceId);
        }

        public void Delete(int id)
        {
            _sequenceScenarioRepository.Delete(id);
        }

        public dynamic GetMaterialList(int sequenceScenarioId)
        {
            var unitSequences = _unitSequenceService.GetBySequenceScenarioId(sequenceScenarioId);
            var materialObject = new ExpandoObject() as IDictionary<string, dynamic>;

            foreach (var unit in unitSequences)
            {
                dynamic materialList = new ExpandoObject();
                if (unit.ProductionUnitType == "Caster") 
                {
                    materialList = _unitSequenceService.GetCasterMaterialList(unit.Id);
                } else if (unit.ProductionUnitType == "HSM") 
                {
                    materialList = _unitSequenceService.GetHSMMaterialList(unit.Id);
                }

                materialObject.Add(unit.ProductionUnitName, materialList);
            }

            return materialObject;
        }

        private void ValidateAddSequenceScenario(SequenceScenario sequenceScenario, GroupSequence groupSequence)
        {
            ValidateSequenceScenario(sequenceScenario, groupSequence);

            if (GetDuplicate(sequenceScenario) != null)
                throw new BadHttpRequestException("You can't add a duplicate sequence scenario");
        }

        private void ValidateUpdateSequenceScenario(SequenceScenario sequenceScenario, GroupSequence groupSequence)
        {
            ValidateSequenceScenario(sequenceScenario, groupSequence);

            SequenceScenario duplicatedSequenceScenario = GetDuplicate(sequenceScenario);

            if (duplicatedSequenceScenario != null && duplicatedSequenceScenario.Id != sequenceScenario.Id)
                throw new BadHttpRequestException("There is already a sequence scenario with the same attributes");
        }

        private void ValidateSequenceScenario(SequenceScenario sequenceScenario, GroupSequence groupSequence)
        {
            if (groupSequence == null)
                throw new BadHttpRequestException("There is no corresponding group sequence for this scenario");

            if (!IsSequenceScenarioValid(sequenceScenario))
                throw new BadHttpRequestException("Please fill all the mandatory fields");

        }

        private int CreateNewSequenceScenarioVersion(int sequenceScenarioId)
        {
            SequenceScenarioVersion sequenceScenarioVersion = new SequenceScenarioVersion()
            {
                Name = "1",
                SequenceScenarioId = sequenceScenarioId
            };
            return _sequenceScenarioVersionService.Add(sequenceScenarioVersion);
        }

        private int CreateUnitSequence(int productionUnitId, int sequenceScenarioVersionId)
        {
            UnitSequence unitSequence = new UnitSequence()
            {
                ProductionUnitId = productionUnitId,
                SequenceScenarioVersionId = sequenceScenarioVersionId
            };
            return _unitSequenceService.Add(unitSequence);
        }

        private bool IsSequenceScenarioValid(SequenceScenario sequenceScenario)
        {
            return !string.IsNullOrEmpty(sequenceScenario.Name);
        }

        private SequenceScenario GetDuplicate(SequenceScenario sequenceScenario)
        {
            return _sequenceScenarioRepository.GetDuplicate(sequenceScenario);
        }
    }
}
