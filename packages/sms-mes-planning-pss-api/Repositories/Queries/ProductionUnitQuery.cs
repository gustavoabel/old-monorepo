namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class ProductionUnitQuery
    {
        public static string GetByProductionUnitGroup => @"
            SELECT pu.id,
            pu.name,
            put.name as type
            FROM pss.production_unit pu
            INNER JOIN pss.production_unit_type put ON pu.production_unit_type_id = put.id
            WHERE pu.production_unit_group_id = @productionUnitGroupId
        ";

        public static string GetCastersByProductionUnitGroupId => @"
            select 
                pu.id,
                pu.name
            from 
                pss.production_unit pu 
                inner join pss.production_unit_type put 
                    on pu.production_unit_type_id = put.id 
            where 
                LOWER(put.name) like '%caster%'
                    and
                pu.production_unit_group_id = @productionUnitGroupId
        ";

        public static string GetAll => @"
            SELECT id,
            name
            FROM pss.production_unit
        ";

        public static string GetOptimizerProductionUnits => @"
            SELECT pu.name as PRODUCTION_UNIT_ID,
            pulc.max_heat_weight as HEAT_LIMIT,
            pulc.max_sequence_size as SEQUENCE_SIZE
            FROM pss.production_unit pu
            INNER JOIN pss.production_unit_type put ON pu.production_unit_type_id = put.id
            INNER JOIN pss.production_unit_limit_configuration pulc ON pulc.production_unit_id = pu.id
            WHERE put.name = 'Caster'
        ";
    }
}