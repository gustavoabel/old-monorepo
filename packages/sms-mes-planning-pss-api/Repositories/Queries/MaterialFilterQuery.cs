namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class MaterialFilterQuery
    {
        public static string GetAll => @"
            SELECT id,
            name,
            description,
            expression,
            is_default as isDefault,
            production_unit_group_id as productionUnitGroupId
            FROM pss.material_filter";

        public static string GetByProductionUnitGroupId => @"
            SELECT mf.id,
            mf.name
            FROM pss.material_filter mf
            WHERE mf.production_unit_group_id = @productionUnitGroupId";

        public static string Add => @"
            INSERT INTO pss.material_filter
            (
                name, 
                description, 
                expression, 
                is_default, 
                production_unit_group_id
            )
	        VALUES 
            (
                @name, 
                @description, 
                cast(@expression as json), 
                @is_default, 
                @production_unit_group_id
            )";

        public static string GetDefault => @"
            SELECT id,
            name,
            description,
            expression,
            is_default as isDefault,
            production_unit_group_id as productionUnitGroupId
            FROM pss.material_filter
            WHERE is_default is true AND production_unit_group_id = @productionUnitGroupId";

        public static string Update => @"
            UPDATE pss.material_filter
            SET
            name = @name, 
            description = @description, 
            expression = cast(@expression as json), 
            is_default = @is_default
            WHERE id = @id";

        public static string Delete => @"
            DELETE FROM pss.material_filter
            WHERE id = @id";

        public static string GetById => @"
            SELECT id,
            name,
            description,
            expression,
            is_default as isDefault,
            production_unit_group_id as productionUnitGroupId
            FROM pss.material_filter
            WHERE id = @id
        ";

        public static string GetCountScenarios => @"
            SELECT COUNT(*)
            FROM pss.material_filter mf
            INNER JOIN pss.sequence_scenario ss on mf.id = ss.material_filter_id
            WHERE mf.id = @id  and ss.deleted = false
        ";
    }
}