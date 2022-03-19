using sms_mes_planning_pss_api.Models;
using sms_mes_planning_pss_api.Repositories.Interfaces;
using sms_mes_planning_pss_api.Services.Interfaces;

using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace sms_mes_planning_pss_api.Services
{
    public class KPIService : IKPIService
    {
        private readonly IKPIRepository _kpiRepository;

        private static List<Func<IEnumerable<MaterialKPI>, KPI>> kpiMethodsList = new List<Func<IEnumerable<MaterialKPI>, KPI>>()
        {
            GetPieces,
            GetCoilMinWidth,
            GetCoilMaxWidth,
            GetCoilMinThickness,
            GetCoilMaxThickness,
            GetSlabMinWeight,
            GetSlabMaxWeight,
            GetSlabTotalWeight,
            GetCoilTotalLength,
            GetCoilSteelGrades,
            GetAverageProductionTime,
        };

        public KPIService(IKPIRepository kpiRepository)
        {
            _kpiRepository = kpiRepository;
        }

        public IEnumerable<KPI> GetBySequenceScenario(int sequenceScenarioId)
        {
            var kpiMaterialList = _kpiRepository.GetBySequenceScenarioId(sequenceScenarioId);

            if (!kpiMaterialList.Any())
                return Enumerable.Empty<KPI>();

            return kpiMethodsList.Select(kpiMethod =>
            {
                return kpiMethod(kpiMaterialList);
            });
        }

        private static KPI GetPieces(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Pieces",
                () => materialKPIList.Where(m => !string.IsNullOrEmpty(m.PieceId)).GroupBy(m => m.PieceId).Count().ToString()
            );
        }

        private static KPI GetCoilMinWidth(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Min. Width",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Coil").Min(m => m.Width).ToString("N", CultureInfo.InvariantCulture)} mm"
            );
        }

        private static KPI GetCoilMaxWidth(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Max. Width",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Coil").Max(m => m.Width).ToString("N", CultureInfo.InvariantCulture)} mm"
            );
        }

        private static KPI GetCoilMinThickness(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Min. Thickness",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Coil").Min(m => m.Thickness).ToString("N", CultureInfo.InvariantCulture)} mm"
            );
        }

        private static KPI GetCoilMaxThickness(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Max. Thickness",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Coil").Max(m => m.Thickness).ToString("N", CultureInfo.InvariantCulture)} mm"
            );
        }

        private static KPI GetSlabMinWeight(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Min. Weight",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Slab").Min(m => m.Weight).ToString("N", CultureInfo.InvariantCulture)} kg"
            );
        }

        private static KPI GetSlabMaxWeight(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Max. Weight",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Slab").Max(m => m.Weight).ToString("N", CultureInfo.InvariantCulture)} kg"
            );
        }

        private static KPI GetSlabTotalWeight(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Total. Weight",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Slab").Sum(m => m.Weight).ToString("N", CultureInfo.InvariantCulture)} kg"
            );
        }

        private static KPI GetCoilTotalLength(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Total. Length",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Coil").Sum(m => m.Length).ToString("N", CultureInfo.InvariantCulture)} mm"
            );
        }

        private static KPI GetCoilSteelGrades(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Steel Grades",
                () => materialKPIList.Where(m => m.MaterialTypeName == "Coil").GroupBy(m => m.SteelGrade).Count().ToString()
            );
        }

        private static KPI GetAverageProductionTime(IEnumerable<MaterialKPI> materialKPIList)
        {
            return GetKPI(
                "Avg. Production Time",
                () => $"{materialKPIList.Where(m => m.MaterialTypeName == "Slab").Average(m => m.ProductionTime).ToString("N", CultureInfo.InvariantCulture)} s"
            );
        }

        private static KPI GetKPI(string label, Func<string> getValue)
        {
            return new KPI()
            {
                Label = label,
                Value = getValue()
            };
        }
    }
}
