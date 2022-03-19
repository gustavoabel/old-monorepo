﻿using sms_mes_planning_pss_api.Models;
using System.Collections.Generic;

namespace sms_mes_planning_pss_api.Repositories.Interfaces
{
    public interface IProductionUnitRepository
    {
        IEnumerable<ProductionUnit> GetByProductionUnitGroupId(int productionUnitGroup);
        IEnumerable<ProductionUnit> GetCastersByProductionUnitGroupId(int productionUnitGroup);
        IEnumerable<ProductionUnit> GetAll();
        IEnumerable<OptimizerProductionUnit> GetOptimizerProductionUnits();
    }
}
