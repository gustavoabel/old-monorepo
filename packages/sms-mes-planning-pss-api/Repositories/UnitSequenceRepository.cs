using System;
using System.Collections.Generic;
using System.Dynamic;
using System.Linq;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class UnitSequenceRepository : IUnitSequenceRepository
    {
        private readonly IBaseRepository _baseRepository;
        public UnitSequenceRepository(IBaseRepository baseRepository)
        {
            _baseRepository = baseRepository;
        }
        public int Add(UnitSequence unitSequence)
        {
            var parameters = new
            {
                sequence_scenario_version_id = unitSequence.SequenceScenarioVersionId,
                production_unit_id = unitSequence.ProductionUnitId
            };
            return _baseRepository.GetQueryResult<int>(UnitSequenceQuery.Add, parameters).FirstOrDefault();
        }
        public UnitSequence GetById(int unitSequenceId)
        {
            var parameters = new
            {
                unitSequenceId
            };
            return _baseRepository.GetQueryResult<UnitSequence>(UnitSequenceQuery.GetById, parameters).FirstOrDefault();
        }
        public IEnumerable<UnitSequence> GetBySequenceScenarioId(int sequenceScenarioId)
        {
            var parameters = new
            {
                sequenceScenarioId
            };
            return _baseRepository.GetQueryResult<UnitSequence>(UnitSequenceQuery.GetBySequenceScenarioId, parameters);
        }
        public IEnumerable<UnitSequence> GetCastersBySequenceScenarioId(int sequenceScenarioId)
        {
            var parameters = new
            {
                sequenceScenarioId
            };
            return _baseRepository.GetQueryResult<UnitSequence>(UnitSequenceQuery.GetCastersBySequenceScenarioId, parameters);
        }
        public UnitSequence GetHSMUnitSequenceByCaster(int CasterUnitSequence)
        {
            var parameters = new
            {
                UnitSequenceId = CasterUnitSequence
            };

            return _baseRepository.GetQueryResult<UnitSequence>(UnitSequenceQuery.GetHSMUnitSequenceByCaster, parameters).FirstOrDefault();
        }
        public IEnumerable<MaterialHeat> GetHeatListByUnitSequence(int unitSequenceId)
        {
            var parameters = new
            {
                unitSequenceId
            };

            IEnumerable<MaterialHeat> heatsResult = _baseRepository
            .GetQueryResult<string>(UnitSequenceQuery.ListHeatsByUnitSequence, parameters)
            .Select(heat => JsonConvert.DeserializeObject<MaterialHeat>(Regex.Replace(heat, @"_", string.Empty)))
            .ToArray();

            return heatsResult;
        }
        public int GetNewSequenceItemOrder(int unitSequenceId)
        {
            try
            {
                var parameters = new
                {
                    unitSequenceId
                };

                return _baseRepository.GetQueryResult<int>(UnitSequenceQuery.NewSequenceItemOrder, parameters).SingleOrDefault<int>();
            }
            catch (Exception)
            {                
                return 1;
            }
        }
        public int GetLastSequenceItemOrder(int unitSequenceId)
        {
            try
            {
                var parameters = new
                {
                    unitSequenceId
                };

                return _baseRepository.GetQueryResult<int>(UnitSequenceQuery.GetLastItemOrder, parameters).SingleOrDefault<int>();
            }
            catch (Exception)
            {                
                return 1;                
            }
        }
        public HSMItemWithCasterUnit GetLastItemOfCaster(int hsmUnitSequenceId, int casterUnitSequenceId)
        {
            try
            {
                var parameters = new
                {
                    hsmUnitSequenceId,
                    casterUnitSequenceId
                };

                return _baseRepository.GetQueryResult<HSMItemWithCasterUnit>(UnitSequenceQuery.GetLastItemOfCaster, parameters).SingleOrDefault<HSMItemWithCasterUnit>();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public HSMItemWithCasterUnit GetLastItemOfDifferentCaster(int hsmUnitSequenceId, int casterUnitSequenceId)
        {
            try
            {
                var parameters = new
                {
                    hsmUnitSequenceId,
                    casterUnitSequenceId
                };

                return _baseRepository.GetQueryResult<HSMItemWithCasterUnit>(UnitSequenceQuery.GetLastItemOfDifferentCaster, parameters).SingleOrDefault<HSMItemWithCasterUnit>();
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public int GetNewOutputOrder(int sequenceItemId)
        {
            var parameters = new
            {
                sequenceItemId
            };

            return _baseRepository.GetQueryResult<int>(UnitSequenceQuery.NewOutputOrder, parameters).SingleOrDefault<int>();
        }
        public bool AddNewInputMaterial(int sequenceItemId, int materialId, int materialOrder)
        {
            try
            {
                var parameters = new
                {
                    sequenceItemId,
                    materialId,
                    materialOrder
                };

                _baseRepository.RunQuery(UnitSequenceQuery.AddInputMaterial, parameters);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public bool AddNewMaterial(int sequenceItemId, int materialId, int materialOrder)
        {
            try
            {
                var parameters = new
                {
                    sequenceItemId,
                    materialId,
                    materialOrder
                };

                _baseRepository.RunQuery(UnitSequenceQuery.AddOutputMaterial, parameters);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public IEnumerable<dynamic> GetCasterMaterialList(int unitSequenceId)
        {
            IEnumerable<dynamic> materialList = _baseRepository
                .GetQueryResult<string>(UnitSequenceQuery.GetCasterMasterialList, new { unitSequenceId })
                .Select(material => JsonConvert.DeserializeObject<ExpandoObject>(material, new ExpandoObjectConverter()))
                .ToArray();

            foreach (var heatGroup in materialList)
            {
                foreach (var material in heatGroup._children)
                {
                    var MaterialsParams = new
                    {
                        sequenceItemId = Int32.Parse(material.sequenceItemId),
                        position = material.position.ToString()
                    };

                    IEnumerable<MaterialRuleViolation> materialRuleViolation = _baseRepository
                        .GetQueryResult<string>(SchedulingRuleViolationQuery.GetViolationForMaterial, MaterialsParams)
                        .Select(ruleViolation => JsonConvert.DeserializeObject<MaterialRuleViolation>(ruleViolation, new ExpandoObjectConverter()))
                        .ToArray();

                    material.violations = materialRuleViolation;

                    IEnumerable<dynamic> childrenList = material._children;

                    foreach (var children in material._children)
                    {
                        IEnumerable<MaterialRuleViolation> childRuleViolation = _baseRepository
                            .GetQueryResult<string>(SchedulingRuleViolationQuery.GetViolationForMaterial, new { sequenceItemId = Int32.Parse(children.sequenceItemId), position = children.position.ToString() })
                            .Select(ruleViolation => JsonConvert.DeserializeObject<MaterialRuleViolation>(ruleViolation, new ExpandoObjectConverter()))
                            .ToArray();

                        children.violations = childRuleViolation;
                    }
                }
            }
            return materialList;
        }
        public IEnumerable<dynamic> GetHSMMaterialList(int unitSequenceId)
        {
            var parameters = new
            {
                unitSequenceId,
            };

            IEnumerable<dynamic> materialList = _baseRepository
                .GetQueryResult<string>(UnitSequenceQuery.GetHSMMasterialList, parameters)
                .Select(material => JsonConvert.DeserializeObject<ExpandoObject>(material, new ExpandoObjectConverter()))
                .ToArray();

            foreach (var material in materialList)
            {
                var MaterialsParams = new
                {
                    sequenceItemId = material.sequenceItemId,
                    position = material.position.ToString()
                };

                IEnumerable<MaterialRuleViolation> materialRuleViolation = _baseRepository
                    .GetQueryResult<string>(SchedulingRuleViolationQuery.GetViolationForMaterial, MaterialsParams)
                    .Select(ruleViolation => JsonConvert.DeserializeObject<MaterialRuleViolation>(ruleViolation, new ExpandoObjectConverter()))
                    .ToArray();

                material.violations = materialRuleViolation;
            }

            return materialList;
        }
        public List<ExpandoObject> GetInputMaterialList(int unitSequenceId)
        {
            return _baseRepository.GetQueryResult<string>(
                UnitSequenceQuery.GetInputMaterialList,
                new
                {
                    unitSequenceId
                }
            )
            .Select(material => JsonConvert.DeserializeObject<ExpandoObject>(material, new ExpandoObjectConverter()))
            .ToList();
        }
        public List<ExpandoObject> GetOutputMaterialList(int unitSequenceId)
        {
            return _baseRepository.GetQueryResult<string>(
                UnitSequenceQuery.GetOutputMaterialList,
                new
                {
                    unitSequenceId
                }
            )
            .Select(material => JsonConvert.DeserializeObject<ExpandoObject>(material, new ExpandoObjectConverter()))
            .ToList();
        }
        public UnitSequenceAttributesSum GetSumOfAttributes(string unitSequenceName, int scenarioId)
        {
            try
            {
                string sumOfAttributes = _baseRepository.GetQueryResult<string>(
                    UnitSequenceQuery.GetSumOfAttributes,
                    new { unitSequenceName, scenarioId }
                ).FirstOrDefault();

                return JsonConvert.DeserializeObject<UnitSequenceAttributesSum>(sumOfAttributes, new ExpandoObjectConverter());
            }
            catch (Exception e)
            {
                throw new Exception(e.ToString());
            }
        }
    }
}
