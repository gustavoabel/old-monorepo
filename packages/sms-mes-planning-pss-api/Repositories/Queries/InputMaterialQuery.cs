namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class InputMaterialQuery
    {
        public static string Add = @"
            INSERT INTO pss.input_material
            (
                material_order,
                sequence_item_id,
                material_id
            )
            VALUES
            (
                @material_order,
                @sequence_item_id,
                @material_id
            )
        ";

        public static string GetBySequenceItem => @"
            select 
                im.material_order as MaterialOrder,
                im.sequence_item_id as SequenceItemId,
                im.material_id as MaterialId
            from pss.input_material im 
            where im.sequence_item_id = @SequenceItemId
        ";
    }
}