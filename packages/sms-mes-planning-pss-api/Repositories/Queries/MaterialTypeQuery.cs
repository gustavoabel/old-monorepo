namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class MaterialTypeQuery
    {
        public static string GetByProductionUnitId => @"
            SELECT mt.id,
                   mt.name
              FROM pss.material_type mt
        INNER JOIN pss.production_unit_material_type pumt ON pumt.material_type_id = mt.id
             WHERE pumt.production_unit_id = @productionUnitId";
    }
}