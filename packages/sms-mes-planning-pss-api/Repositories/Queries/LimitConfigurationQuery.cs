namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class LimitConfigurationQuery
    {
        public static string GetAll => @"
         select pulc.id,
                pulc.min_heat_weight as minHeatWeight,
                pulc.max_heat_weight as maxHeatWeight,
                pulc.min_sequence_size as minSequenceSize,
                pulc.max_sequence_size as maxSequenceSize,
                pulc.production_unit_id as productionUnitId,
                pu.name as name
           from pss.production_unit_limit_configuration pulc
     inner join pss.production_unit pu 
             on pulc.production_unit_id = pu.id  
        ";

        public static string Update => @"
         UPDATE pss.production_unit_limit_configuration
            SET min_heat_weight = @min_heat_weight,
                max_heat_weight = @max_heat_weight,
                min_sequence_size = @min_sequence_size,
                max_sequence_size = @max_sequence_size
          WHERE id = @id
        ";
    }
}