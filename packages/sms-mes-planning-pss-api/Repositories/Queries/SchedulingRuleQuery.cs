namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class SchedulingRuleQuery
    {
        public static string Add => @"
            INSERT INTO pss.scheduling_rule
            (
                name,
                remark,
                implementation,
                implementation_transpiled,
                material_attribute_definition_id,
                production_unit_id
            )
	        VALUES 
            (
                @name,
                @remark,
                @implementation,
                @implementation_transpiled,
                @material_attribute_definition_id,
                @production_unit_id
            ) RETURNING id";

        public static string Delete => @"
            DELETE FROM pss.scheduling_rule
            WHERE id= @id
        ";

        public static string Update => @"
            UPDATE pss.scheduling_rule
            SET name = @name,
            remark = @remark,
            implementation = @implementation,
            implementation_transpiled = @implementation_transpiled,
            material_attribute_definition_id = @material_attribute_definition_id,
            production_unit_id = @production_unit_id
            WHERE id = @id
        ";

        public static string GetAll => @"
            SELECT sr.id,
            sr.name,
            sr.remark,
            sr.implementation,
            sr.implementation_transpiled as ImplementationTranspiled,
            sr.material_attribute_definition_id as materialAttributeDefinitionId,
            sr.production_unit_id as productionUnitId,
            mad.material_type_id as materialTypeId
            FROM pss.scheduling_rule sr
            INNER JOIN pss.material_attribute_definition mad ON mad.id = sr.material_attribute_definition_id
        ";
    }
}