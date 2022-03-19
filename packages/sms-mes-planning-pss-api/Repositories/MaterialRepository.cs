using System;
using System.Dynamic;
using System.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Repositories.Queries;

namespace sms_mes_planning_pss_api.Repositories
{
    public class MaterialRepository : IMaterialRepository
    {
        private readonly ISequenceItemRepository _sequenceItemRepository;
        private readonly IHeatGroupRepository _heatGroupRepository;
        private readonly IBaseRepository _baseRepository;

        public MaterialRepository(IBaseRepository baseRepository, ISequenceItemRepository sequenceItemRepository, IHeatGroupRepository heatGroupRepository)
        {
            _baseRepository = baseRepository;
            _sequenceItemRepository = sequenceItemRepository;
            _heatGroupRepository = heatGroupRepository;
        }
        public dynamic GetMaterialById(int MaterialId)
        {
            dynamic Result = _baseRepository.GetQueryResult<dynamic>(MaterialQuery.GetById, new { MaterialID = MaterialId }).SingleOrDefault();

            return JsonConvert.DeserializeObject<ExpandoObject>(Result.data, new ExpandoObjectConverter());
        }
        public Material GetMaterialByPieceId(string PieceId, int MaterialType = 2)
        {
            Material Result = _baseRepository.GetQueryResult<Material>(MaterialQuery.GetByPieceId, new { pieceId = PieceId, materialType = MaterialType }).SingleOrDefault();

            return Result;
        }
        public IEnumerable<dynamic> GetAvailableMaterialsToAdd(int? productionUnitId, int sequenceScenarioId, int groupSequenceId, string planningHorizonQuery)
        {
            var parameters = new
            {
                productionUnitId,
                sequenceScenarioId,
                groupSequenceId,
            };

            IEnumerable<dynamic> materialsResult = _baseRepository
                .GetQueryResult<string>(MaterialQuery.ListAvailableMaterialsToAdd(planningHorizonQuery), parameters)
                .Select(material => JsonConvert.DeserializeObject<ExpandoObject>(material, new ExpandoObjectConverter()))
                .ToArray();

            return materialsResult;
        }
        public int GetMaterialOrderSendToMES(int SequenceItemId, int MaterialId)
        {
            var parameters = new
            {
                sequenceItemId = SequenceItemId,
                materialId = MaterialId
            };
            return _baseRepository.GetQueryResult<int>(MaterialQuery.GetMaterialOrderSendToMES, parameters).SingleOrDefault();            
        }
        public IEnumerable<int> GetOutputMaterialBySequenceItemId(int SequenceItemId)
        {
            var parameters = new
            {
                sequenceItemId = SequenceItemId
            };
            return _baseRepository.GetQueryResult<int>(MaterialQuery.GetOutputMaterialBySequenceItemId, parameters);
        }
        public IEnumerable<dynamic> GetMaterialsSendToMES(IEnumerable<int> materialIdList)
        {
            var parameters = new
            {
                materialIdList = materialIdList.ToArray()
            };
            return _baseRepository.GetQueryResult<dynamic>(MaterialQuery.GetMaterialsSendToMES, parameters);
        }
        public IEnumerable<dynamic> GetMaterialsGroupedByPieceId(IEnumerable<string> pieceIdList)
        {
            var parameters = new
            {
                pieceIdList = pieceIdList.ToArray()
            };
            return _baseRepository.GetQueryResult<dynamic>(MaterialQuery.GetMaterialsGroupedByPieceId, parameters);
        }
        public int GetRelatedCoil(string PieceId)
        {
            return _baseRepository.GetQueryResult<int>(MaterialQuery.GetRelatedCoil, new { PieceId = PieceId }).SingleOrDefault();
        }
        public Material AddNewMaterial(int materialTypeId)
        {
            var parameters = new
            {
                weight = 0,
                materialTypeId
            };

            return _baseRepository.GetQueryResult<Material>(MaterialQuery.AddNewMaterial, parameters).SingleOrDefault();
        }
        public Material AddNewHeat(int SlabId)
        {
            var parameters = new
            {
                weight = 0,
                materialTypeId = 1
            };

            dynamic SlabInfo = this.GetMaterialById(SlabId);

            if (SlabInfo != null)
            {
                dynamic Heat = new ExpandoObject();
                Heat.STEEL_GRADE_INT = SlabInfo.STEEL_GRADE_INT;
                Heat.HEAT_WEIGHT = SlabInfo.SLAB_WEIGHT_AIM;

                Material NewHeat = _baseRepository.GetQueryResult<Material>(MaterialQuery.AddNewMaterial, parameters).SingleOrDefault();

                AddMaterialAttributes(NewHeat.id, 1, Heat);

                return NewHeat;
            }

            return default;
        }
        public void UpdateMaterialHeatWeight(double weight, int materialId)
        {
            var parameters = new { weight, materialId };
            _baseRepository.RunQuery(MaterialQuery.UpdateMaterialWeight, parameters);            
        }
        public double GetHeatWeightByMaterialId(int MaterialId)
        {
            return _baseRepository.GetQueryResult<double>(MaterialQuery.GetHeatWeightByMaterialId, new { materialId = MaterialId }).SingleOrDefault();
        }
        public int GetMaterialIdBySequeceItemId(int SequenceItemId)
        {
            return _baseRepository.GetQueryResult<int>(MaterialQuery.GetMaterialIdBySequeceItemId, new { sequenceItemId = SequenceItemId }).SingleOrDefault();
        }
        public void AddMaterialAttributes(int materialId, int materialTypeId, dynamic material)
        {
            foreach (KeyValuePair<string, object> key in material)
            {
                string materialAttribute = Regex.Replace(key.Key.ToString(), @"\s+", "");

                MaterialAttributeDefinition attributeDefinition = _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetByAttributeName(materialAttribute, materialTypeId)).SingleOrDefault();

                if (attributeDefinition != null)
                {
                    var materialParameters = new
                    {
                        value = key.Value,
                        materialId,
                        materialAttributeId = attributeDefinition.Id
                    };

                    _baseRepository.RunQuery(MaterialQuery.AddAttributesToNewMaterial, materialParameters);
                }
            }
        }
        public void UpdateMaterialAttributes(int materialId, int materialTypeId, dynamic material)
        {
            foreach (KeyValuePair<string, object> key in material)
            {
                string materialAttribute = Regex.Replace(key.Key.ToString(), @"\s+", "");

                MaterialAttributeDefinition attributeDefinition = _baseRepository.GetQueryResult<MaterialAttributeDefinition>(MaterialAttributeDefinitionQuery.GetByAttributeName(materialAttribute, materialTypeId)).SingleOrDefault();

                if (attributeDefinition != null)
                {
                    var materialParameters = new
                    {
                        value = key.Value,
                        materialId,
                        materialAttributeId = attributeDefinition.Id
                    };

                    _baseRepository.RunQuery(MaterialQuery.UpdateAttributesOfMaterial, materialParameters);
                }
            }
        }
        public bool MoveToFirst(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<SequenceItem> MaterialsToChange = _baseRepository.GetQueryResult<SequenceItem>(
                    MaterialQuery.GetItemsFromSameSequence("and si.item_order < si2.item_order"),
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId
                    }
                );

                foreach (var material in MaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveItemToNewPosition,
                        new
                        {
                            sequenceItemId = material.Id,
                            itemOrder = material.ItemOrder + 1
                        }
                    );
                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveItemToNewPosition,
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = 1
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveToLast(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<SequenceItem> MaterialsToChange = _baseRepository.GetQueryResult<SequenceItem>(
                    MaterialQuery.GetItemsFromSameSequence("and si.item_order > si2.item_order"),
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId
                    }
                );

                int lastPosition = _baseRepository.GetQueryResult<int>(
                    MaterialQuery.GetLastItemOrder,
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId
                    }
                ).SingleOrDefault();

                foreach (var material in MaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveItemToNewPosition,
                        new
                        {
                            sequenceItemId = material.Id,
                            itemOrder = material.ItemOrder - 1
                        }
                    );
                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveItemToNewPosition,
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = lastPosition
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveToMiddle(MaterialMovementBody materialMovementBody)
        {
            try
            {
                string WhereClause = @"";

                if (materialMovementBody.OldPosition > materialMovementBody.NewPositon)
                {
                    WhereClause = $@"and si.item_order >= {materialMovementBody.NewPositon} and si.item_order < {materialMovementBody.OldPosition}";
                }
                else
                {
                    WhereClause = $@"and si.item_order <= {materialMovementBody.NewPositon} and si.item_order > {materialMovementBody.OldPosition}";
                }

                IEnumerable<SequenceItem> MaterialsToChange = _baseRepository.GetQueryResult<SequenceItem>(
                    MaterialQuery.GetItemsFromSameSequence(WhereClause),
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        OldPosition = materialMovementBody.OldPosition,
                        NewPositon = materialMovementBody.NewPositon
                    }
                );

                foreach (var material in MaterialsToChange)
                {
                    if (materialMovementBody.OldPosition > materialMovementBody.NewPositon)
                    {
                        _baseRepository.RunQuery(
                            MaterialQuery.MoveItemToNewPosition,
                            new
                            {
                                sequenceItemId = material.Id,
                                itemOrder = material.ItemOrder + 1
                            }
                        );
                    }
                    else
                    {
                        _baseRepository.RunQuery(
                            MaterialQuery.MoveItemToNewPosition,
                            new
                            {
                                sequenceItemId = material.Id,
                                itemOrder = material.ItemOrder - 1
                            }
                        );
                    }

                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveItemToNewPosition,
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = materialMovementBody.NewPositon
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveOutputToFirstOnSameItem(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<MaterialOutput> MaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromTheSameItem("and om.material_order < om2.material_order"),
                    new
                    {
                        materialId = materialMovementBody.MaterialId
                    }
                );

                foreach (var material in MaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder + 1
                        }
                    );
                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveOutputMaterialOnSameItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = 1
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveOutputToFirstOnDifferentItem(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<MaterialOutput> OldItemMaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromTheSameItem("and om.material_order > om2.material_order"),
                    new
                    {
                        materialId = materialMovementBody.MaterialId
                    }
                );

                foreach (var material in OldItemMaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder - 1
                        }
                    );
                }

                IEnumerable<MaterialOutput> NewItemMaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromDifferentItem(""),
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId
                    }
                );

                foreach (var material in NewItemMaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder + 1
                        }
                    );
                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveOutputMaterialOnDifferentItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                        oldSequenceItemId = materialMovementBody.OldSequenceItemId,
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = 1
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveOutputToLastOnSameItem(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<MaterialOutput> MaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromTheSameItem("and om.material_order > om2.material_order"),
                    new
                    {
                        materialId = materialMovementBody.MaterialId
                    }
                );

                int lastPosition = _baseRepository.GetQueryResult<int>(
                    MaterialQuery.GetLastOutputOrderFromTheSameItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId
                    }
                ).SingleOrDefault();

                foreach (var material in MaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder - 1
                        }
                    );
                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveOutputMaterialOnSameItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = lastPosition
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveOutputToLastOnDifferentItem(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<MaterialOutput> OldItemMaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromTheSameItem("and om.material_order > om2.material_order"),
                    new
                    {
                        materialId = materialMovementBody.MaterialId
                    }
                );

                foreach (var material in OldItemMaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder - 1
                        }
                    );
                }

                int lastPosition = _baseRepository.GetQueryResult<int>(
                    MaterialQuery.GetLastOutputOrderFromDifferentItem,
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId
                    }
                ).SingleOrDefault();

                _baseRepository.RunQuery(
                    MaterialQuery.MoveOutputMaterialOnDifferentItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                        oldSequenceItemId = materialMovementBody.OldSequenceItemId,
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = lastPosition + 1
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveOutputToMiddleOnSameItem(MaterialMovementBody materialMovementBody)
        {
            try
            {
                string WhereClause = @"";

                if (materialMovementBody.OldPosition > materialMovementBody.NewPositon)
                {
                    WhereClause = $@"and om.material_order >= {materialMovementBody.NewPositon} and om.material_order < {materialMovementBody.OldPosition}";
                }
                else
                {
                    WhereClause = $@"and om.material_order <= {materialMovementBody.NewPositon} and om.material_order > {materialMovementBody.OldPosition}";
                }

                IEnumerable<MaterialOutput> MaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromTheSameItem(WhereClause),
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                    }
                );

                foreach (var material in MaterialsToChange)
                {
                    if (materialMovementBody.OldPosition > materialMovementBody.NewPositon)
                    {
                        _baseRepository.RunQuery(
                            MaterialQuery.MoveOutputMaterialOnSameItem,
                            new
                            {
                                materialId = material.MaterialId,
                                sequenceItemId = material.SequenceItemId,
                                itemOrder = material.ItemOrder + 1
                            }
                        );
                    }
                    else
                    {
                        _baseRepository.RunQuery(
                            MaterialQuery.MoveOutputMaterialOnSameItem,
                            new
                            {
                                materialId = material.MaterialId,
                                sequenceItemId = material.SequenceItemId,
                                itemOrder = material.ItemOrder - 1
                            }
                        );
                    }

                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveOutputMaterialOnSameItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = materialMovementBody.NewPositon
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool MoveOutputToMiddleOnDifferentItem(MaterialMovementBody materialMovementBody)
        {
            try
            {
                IEnumerable<MaterialOutput> OldItemMaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromTheSameItem("and om.material_order > om2.material_order"),
                    new
                    {
                        materialId = materialMovementBody.MaterialId
                    }
                );

                foreach (var material in OldItemMaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder - 1
                        }
                    );
                }

                IEnumerable<MaterialOutput> NewItemMaterialsToChange = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromDifferentItem($@"and om.material_order >= {materialMovementBody.NewPositon}"),
                    new
                    {
                        sequenceItemId = materialMovementBody.SequenceItemId
                    }
                );

                foreach (var material in NewItemMaterialsToChange)
                {
                    _baseRepository.RunQuery(
                        MaterialQuery.MoveOutputMaterialOnSameItem,
                        new
                        {
                            materialId = material.MaterialId,
                            sequenceItemId = material.SequenceItemId,
                            itemOrder = material.ItemOrder + 1
                        }
                    );
                }

                _baseRepository.RunQuery(
                    MaterialQuery.MoveOutputMaterialOnDifferentItem,
                    new
                    {
                        materialId = materialMovementBody.MaterialId,
                        oldSequenceItemId = materialMovementBody.OldSequenceItemId,
                        sequenceItemId = materialMovementBody.SequenceItemId,
                        itemOrder = materialMovementBody.NewPositon
                    }
                );

                return true;
            }
            catch (Exception err)
            {
                Console.WriteLine(err);
                throw;
            }
        }
        public bool RemoveSequenceItemWithMaterials(RemoveMaterial materialData)
        {
            try
            {
                IEnumerable<MaterialOutput> outputList = _baseRepository.GetQueryResult<MaterialOutput>(
                    SequenceItemQuery.OutputMaterialBySequenceItem,
                    new { sequenceItemId = materialData.SequenceItemId }
                );

                foreach (MaterialOutput output in outputList)
                {
                    RemoveMaterial material = new RemoveMaterial
                    {
                        MaterialId = output.Id,
                        SequenceItemId = output.SequenceItemId,
                        SequenceScenarioId = materialData.SequenceScenarioId
                    };

                    bool isSlabRemoved = this.RemoveSlab(material);

                    if (!isSlabRemoved)
                    {
                        throw new Exception("Some error ocurred while trying to remove the slab");
                    }
                }

                _baseRepository.RunQuery(
                    MaterialQuery.DeleteCasterSequenceItem,
                    new { sequenceItemId = materialData.SequenceItemId }
                );

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }

        }
        public bool RemoveSlab(RemoveMaterial materialData)
        {
            try
            {
                int hsmSequenceItemId = _baseRepository.GetQueryResult<int>(
                    MaterialQuery.HSMSequenceItemBySlab,
                    new { materialId = materialData.MaterialId, sequenceScenarioId = materialData.SequenceScenarioId }
                ).SingleOrDefault();

                _baseRepository.RunQuery(MaterialQuery.DeleteHSMSequenceItem, new { hsmSequenceItemId = hsmSequenceItemId });
                _baseRepository.RunQuery(MaterialQuery.DeleteCasterOutputMaterial, new { materialId = materialData.MaterialId, sequenceItemId = materialData.SequenceItemId });

                int heatGroupId = _sequenceItemRepository.GetHeatGroupIdById(materialData.SequenceItemId);                

                bool hasOutput = this.CheckIfHasOutput(materialData.SequenceItemId);

                if (!hasOutput)                
                    _baseRepository.RunQuery(MaterialQuery.DeleteCasterSequenceItem, new { sequenceItemId = materialData.SequenceItemId });                

                int countHeatGroup = _sequenceItemRepository.GetCountHeatGroup(heatGroupId);

                if (countHeatGroup == 0)
                    _heatGroupRepository.Delete(heatGroupId);

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public bool RemoveCoil(RemoveMaterial materialData)
        {
            try
            {
                MaterialOutput casterMaterialOutput = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.CasterSlabByCoilSequenceItem,
                    new { sequenceItemId = materialData.SequenceItemId }
                ).SingleOrDefault();

                _baseRepository.RunQuery(
                    MaterialQuery.DeleteCasterOutputMaterial,
                    new
                    {
                        materialId = casterMaterialOutput.MaterialId,
                        sequenceItemId = casterMaterialOutput.SequenceItemId
                    }
                );
                _baseRepository.RunQuery(MaterialQuery.DeleteHSMSequenceItem, new { hsmSequenceItemId = materialData.SequenceItemId });


                bool hasOutput = this.CheckIfHasOutput(casterMaterialOutput.SequenceItemId);

                if (!hasOutput)
                {
                    _baseRepository.RunQuery(MaterialQuery.DeleteCasterSequenceItem, new { sequenceItemId = casterMaterialOutput.SequenceItemId });
                }

                return true;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
                throw;
            }
        }
        public dynamic CheckMaterialUsage(RemoveMaterial materialData)
        {
            MaterialOutput materialInput = this.CheckIfIsInput(materialData);

            if (materialInput == null)
            {
                MaterialOutput materialOutput = this.CheckIfIsOutput(materialData);

                if (materialOutput == null)
                {
                    throw new Exception("Material was not found.");
                }

                return new
                {
                    usage = "Output",
                    material = materialOutput
                };
            }

            return new
            {
                usage = "Input",
                material = materialInput
            };
        }
        private MaterialOutput CheckIfIsInput(RemoveMaterial materialData)
        {
            var parameters = new
            {
                materialId = materialData.MaterialId,
                sequenceItemId = materialData.SequenceItemId
            };

            return _baseRepository.GetQueryResult<MaterialOutput>(MaterialQuery.CheckIfItsInput, parameters).SingleOrDefault();
        }
        private MaterialOutput CheckIfIsOutput(RemoveMaterial materialData)
        {
            var parameters = new
            {
                materialId = materialData.MaterialId,
                sequenceItemId = materialData.SequenceItemId
            };

            return _baseRepository.GetQueryResult<MaterialOutput>(MaterialQuery.CheckIfItsOutput, parameters).SingleOrDefault();
        }
        private bool CheckIfHasOutput(int sequenceItemId)
        {
            try
            {
                List<MaterialOutput> outputList = _baseRepository.GetQueryResult<MaterialOutput>(
                    MaterialQuery.GetOutputMaterialsFromDifferentItem(""),
                    new { sequenceItemId = sequenceItemId }
                ).ToList();

                if (outputList == null || outputList.Count() <= 0)
                {
                    return false;
                }

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