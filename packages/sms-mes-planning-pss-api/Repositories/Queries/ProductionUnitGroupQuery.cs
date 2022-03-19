namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class ProductionUnitGroupQuery
    {
        public static string GetAll => @"
             SELECT pug.id,
                    pug.name,
                    pug.has_predecessor as hasPredecessor,
                    pug.has_successor as hasSuccessor,
                    pugul.layout
               FROM pss.production_unit_group pug
         INNER JOIN pss.production_unit_group_ui_layout pugul 
                 ON pugul.production_unit_group_id = pug.id";
    }
}