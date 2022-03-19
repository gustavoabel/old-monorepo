using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Services.Interfaces
{
    public interface IMaterialService
    {
        IEnumerable<dynamic> GetAvailableMaterialsToAdd(int? productionUnitId, int sequenceScenarioId, int groupSequenceId, int? materialFilterId, int? planningHorizonId);
        IEnumerable<dynamic> GetMaterialsGroupedByPieceId(int sequenceScenarioId, int groupSequenceId, int? materialFilterId, int? planningHorizonId);
        bool MoveMaterial(MaterialMovementBody materialMovementBody);
        bool RemoveFromUnit(RemoveMaterial materialData);
    }
}
