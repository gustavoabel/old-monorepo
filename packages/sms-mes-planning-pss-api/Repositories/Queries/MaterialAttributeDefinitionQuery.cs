namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class MaterialAttributeDefinitionQuery
    {
        public static string GetPlanningHorizonOptions => @"
            select 
                mad.id,
                mad.name,
                mad.type
            from pss.material_attribute_definition mad
                inner join pss.material_type mt 
                    on mt.id = mad.material_type_id
                inner join pss.production_unit_material_type pumt 
                    on pumt.material_type_id = mt.id
                inner join pss.production_unit pu 
                    on pu.id = pumt.production_unit_id
                inner join pss.production_unit_type put 
                    on pu.production_unit_type_id = put.id 
                inner join pss.production_unit_group pug 
                    on pug.id = pu.production_unit_group_id
            where 
                lower(put.name) = 'caster' 
                and pumt.is_output is true 
                and mad.type = 'date'
                and pug.id = @productionUnitGroupId
            group by mad.id;
        ";
        public static string GetByProductionUnitGroupId(string Where) => $@"
            SELECT mad.id,
            CONCAT(mad.name,' (',mt.name,')') as name,
            mad.type
            FROM pss.material_attribute_definition mad
            INNER JOIN pss.material_type mt ON mt.id = material_type_id
            INNER JOIN pss.production_unit_material_type pumt ON pumt.material_type_id = mt.id
            INNER JOIN pss.production_unit pu ON pu.id = pumt.production_unit_id
            INNER JOIN pss.production_unit_group pug ON pug.id = pu.production_unit_group_id
            WHERE pug.id = @productionUnitGroupId
            {Where}
            GROUP BY mad.id,
            CONCAT(mad.name,' (',mt.name,')'),
            mad.type
        ";
        public static string GetByMaterialType => @"
            SELECT 
                mad.id,
                mad.name,
                mad.type
            FROM 
                pss.material_attribute_definition mad
                    INNER JOIN pss.material_type mt 
                        ON mt.id = mad.material_type_id
            WHERE 
                mad.material_type_id = @materialTypeId
        ";
        public static string GetByProductionUnitId => @"
            SELECT mad.id,
            mad.name,
            mad.type
            FROM pss.material_attribute_definition mad
            INNER JOIN pss.material_type mt ON mt.id = material_type_id
            INNER JOIN pss.production_unit_material_type pumt ON pumt.material_type_id = mt.id
            INNER JOIN pss.production_unit pu ON pu.id = pumt.production_unit_id
            WHERE pu.id = @productionUnitId
            GROUP BY mad.id,
            mad.name,
            mad.type
        ";
        public static string GetByMaterialTypeAndAttributeName => @"
            SELECT 
                mad.id,
                mad.name,
                mad.type
            FROM 
                pss.material_attribute_definition mad
                    INNER JOIN pss.material_type mt 
                        ON mt.id = mad.material_type_id
            WHERE 
                lower(mad.name) = lower(@materialAttributeDefinitionName)
                    AND
                lower(mt.name) = lower(@materialTypeName)
        ";
        public static string GetAddMaterialAttributes = @"
            select 
                mad.id,
                case
                    when mad.type = 'text' then REPLACE(mad.name, '_', ' ')
                else concat(REPLACE(mad.name, '_', ' '), ' (', mad.uom, ')')
                    end as name,
                mad.type
            from 
                pss.material_attribute_definition mad
                    inner join pss.material_type mt 
                        on mt.id = material_type_id
                    inner join pss.production_unit_material_type pumt 
                        on pumt.material_type_id = mt.id
                    inner join pss.production_unit pu 
                        on pu.id = pumt.production_unit_id
                    inner join pss.unit_sequence us 
                        on pu.id = us.production_unit_id 
            where 
                us.id = :productionUnitId
                    and 
                lower(mt.name) = 'slab'
            group by 
                mad.id,
                mad.name,
                mad.type

            union
                select
                    mad2.id,
                    case
                        when mad2.type = 'text' then REPLACE(mad2.name, '_', ' ')
                    else concat(REPLACE(mad2.name, '_', ' '), ' (', mad2.uom, ')')
                        end as name,
                    mad2.type
                from
                    pss.material_attribute_definition mad2
                where
                    mad2.material_type_id = 3
                        and
                    lower(mad2.name) like '%aim%'
                group by 
                mad2.id,
                mad2.name,
                mad2.type

            union 
                select 0, 'type', 'text'
            
            order by id
        ";
        public static string GetByAttributeName(string attributeName, int materialTypeId) => $@"
            select 
                mad.id, 
                mad.name, 
                mad.type
            from 
                pss.material_attribute_definition mad
            group by 
                mad.material_type_id, 
                mad.id
            having
                mad.name = '{attributeName}' 
                    and 
                mad.material_type_id = {materialTypeId}
            order by mad.id;
        ";

        public static string GetTitleByField = @"
           select mad.name
             from pss.material_attribute_definition mad 
            where mad.id = @field
        ";

        public static string GetCustomColumnOrder = @"
            select column_order
            from pss.custom_column_order cco 
            where cco.table_name = @tableType and cco.user_id = @userId
        ";

        public static string SetCustomColumnOrder = @"
            insert into pss.custom_column_order(table_name, user_id, column_order)
            values(@tableType, @userId, @columnOrder)
        ";

        public static string UpdateCustomColumnOrder = @"
            update pss.custom_column_order
            set column_order = @columnOrder
            where table_name = @tableType and user_id = @userId
        ";
    }
}