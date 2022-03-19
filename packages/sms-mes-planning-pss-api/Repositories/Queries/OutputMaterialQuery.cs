namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class OutputMaterialQuery
    {
        public static string Add = @"
            INSERT INTO pss.output_material
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
    }
}