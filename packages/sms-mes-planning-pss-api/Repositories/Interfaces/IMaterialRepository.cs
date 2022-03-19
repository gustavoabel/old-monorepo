using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IMaterialRepository
    {
        dynamic GetMaterialById(int MaterialId);
        Material GetMaterialByPieceId(string PieceId, int MaterialType);
        IEnumerable<dynamic> GetAvailableMaterialsToAdd(int? productionUnitId, int sequenceScenarioId, int groupSequenceId, string planningHorizonQuery);
        IEnumerable<int> GetOutputMaterialBySequenceItemId(int sequenceItemId);
        IEnumerable<dynamic> GetMaterialsGroupedByPieceId(IEnumerable<string> materialIdList);
        IEnumerable<dynamic> GetMaterialsSendToMES(IEnumerable<int> materialIdList);
        int GetMaterialOrderSendToMES(int SequenceItemId, int MaterialId);
        int GetRelatedCoil(string PieceId);
        Material AddNewMaterial(int materialTypeId);
        Material AddNewHeat(int SlabId);
        int GetMaterialIdBySequeceItemId(int SequenceItemId);
        void UpdateMaterialHeatWeight(double weight, int materialId);
        double GetHeatWeightByMaterialId(int MaterialId);
        void AddMaterialAttributes(int materialId, int materialTypeId, dynamic material);
        void UpdateMaterialAttributes(int materialId, int materialTypeId, dynamic material);
        bool MoveToFirst(MaterialMovementBody materialMovementBody);
        bool MoveToLast(MaterialMovementBody materialMovementBody);
        bool MoveToMiddle(MaterialMovementBody materialMovementBody);
        bool MoveOutputToFirstOnSameItem(MaterialMovementBody materialMovementBody);
        bool MoveOutputToFirstOnDifferentItem(MaterialMovementBody materialMovementBody);
        bool MoveOutputToLastOnSameItem(MaterialMovementBody materialMovementBody);
        bool MoveOutputToLastOnDifferentItem(MaterialMovementBody materialMovementBody);
        bool MoveOutputToMiddleOnSameItem(MaterialMovementBody materialMovementBody);
        bool MoveOutputToMiddleOnDifferentItem(MaterialMovementBody materialMovementBody);
        dynamic CheckMaterialUsage(RemoveMaterial materialData);
        bool RemoveSequenceItemWithMaterials(RemoveMaterial materialData);
        bool RemoveSlab(RemoveMaterial materialData);
        bool RemoveCoil(RemoveMaterial materialData);
    }
}
