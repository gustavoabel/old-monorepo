namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class PlanningHorizonQuery
    {
        public static string GetAll => @"
            SELECT id,
            horizon,
            name,
            description,
            is_default as isDefault,
            production_unit_group_id as productionUnitGroupId,
            material_attribute_definition_id as materialAttributeDefinitionId
            FROM pss.planning_horizon
            ORDER BY horizon asc";

        public static string GetByProductionUnitGroupId => @"
            SELECT ph.id,
            ph.name
            FROM pss.planning_horizon ph
            WHERE ph.production_unit_group_id = @productionUnitGroupId
            ORDER BY ph.horizon asc";

        public static string GetDefault => @"
            SELECT id,
            horizon,
            name,
            description,
            is_default as isDefault,
            production_unit_group_id as productionUnitGroupId,
            material_attribute_definition_id as materialAttributeDefinitionId
            FROM pss.planning_horizon
            WHERE is_default is true AND production_unit_group_id = @productionUnitGroupId
            ORDER BY horizon asc";

        public static string Add => @"
             INSERT INTO pss.planning_horizon
             (
	            horizon, 
                name, 
                description, 
                is_default, 
                production_unit_group_id, 
                material_attribute_definition_id
            )
	        VALUES 
            (
                @horizon, 
                @name, 
                @description, 
                @is_default, 
                @production_unit_group_id, 
                @material_attribute_definition_id
            );";

        public static string Update => @"
            UPDATE 
                pss.planning_horizon
            SET
                horizon = @horizon, 
                name = @name, 
                description = @description, 
                is_default = @is_default,  
                material_attribute_definition_id =  @material_attribute_definition_id
            WHERE id = @id";

        public static string Delete => @"
             DELETE FROM pss.planning_horizon
             WHERE id = @id";

        public static string GetById => @"
            SELECT id,
            horizon,
            name,
            description,
            is_default as isDefault,
            production_unit_group_id as productionUnitGroupId,
            material_attribute_definition_id as materialAttributeDefinitionId
            FROM pss.planning_horizon
            WHERE id = @id
        ";

        public static string GetForQuery = @"
        select mad.name, ph.horizon
        from pss.planning_horizon ph 
            inner join pss.material_attribute_definition mad on ph.material_attribute_definition_id = mad.id
        where ph.id = @planningHorizonId
    ";
    }
}