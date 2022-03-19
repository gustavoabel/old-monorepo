namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class SequenceItemQuery
    {
        public static string GetById => @"
            select
                si.id as Id,
                si.item_order as ItemOrder,
                si.unit_sequence_id as UnitSequenceId,
                si.heat_group_id as HeatGroupId
            from
                pss.sequence_item si 
            where
                si.id = :sequenceItemId;
        ";
        public static string Add => @"
            INSERT INTO pss.sequence_item
            (
                item_order,
                unit_sequence_id,
                heat_group_id
            )
            VALUES
            (
                @item_order,
                @unit_sequence_id,
                @heat_group_id
            )
            RETURNING id
        ";
        public static string GetProductionUnitBySequenceItem => @"
            select 
                pu.id as Id,
                pu.name as Name,
                put.name as Type
            from 
                pss.sequence_item si 
                    inner join pss.unit_sequence us 
                        on si.unit_sequence_id = us.id 
                    inner join pss.production_unit pu 
                        on us.production_unit_id = pu.id
                    inner join pss.production_unit_type put 
                        on pu.production_unit_type_id = put.id
            where
                si.id = @sequenceItemId
        ";
        public static string OutputMaterialBySequenceItem => @"
            select
                om.id as Id,
                om.item_order as ItemOrder,
                om.material_id as MaterialId,
                om.sequence_item_id as SequenceItemId
            from
                pss.output_material om
            where
                om.sequence_item_id = @sequenceItemId;
        ";
        public static string GetHeatGroupIdByItemOrder => @"
            Select heat_group_id  as HeatGroupId
              From pss.sequence_item si
        inner join pss.heat_group hg 
                on hg.id = si.heat_group_id 
             Where si.item_order       = @itemOrder
               and hg.unit_sequence_id = @unitSequenceId
        ";
        public static string GetCountHeatGroup => @"
            Select Count(*)
              From pss.sequence_item si        
             Where si.heat_group_id = @heatGroupId
        ";
        public static string GetHeatGroupIdById => @"
            Select coalesce(si.heat_group_id, 0)
              From pss.sequence_item si        
             Where si.id = @id
        ";
    }
}