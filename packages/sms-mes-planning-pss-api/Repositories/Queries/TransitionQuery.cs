namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class TransitionQuery
    {
        public static string GetAllTransitions => @"
            SELECT
                mat.id as Id,
                mat.material_attribute_definition_id as MaterialAttributeDefinitionId, 
                mad.name as MaterialAttributeDefinitionName,
                mat.transition_from as From, 
                mat.transition_to as To, 
                mat.classification as Classification, 
                mat.active as Active
            FROM
                pss.material_attribute_transition mat
                    INNER JOIN pss.material_attribute_definition mad
                        ON mat.material_attribute_definition_id = mad.id;
        ";
        public static string GetTransitionById => @"
            SELECT
                mat.id as Id,
                mat.material_attribute_definition_id as MaterialAttributeDefinitionId, 
                mad.name as MaterialAttributeDefinitionName,
                mat.transition_from as From, 
                mat.transition_to as To, 
                mat.classification as Classification, 
                mat.active as Active
            FROM
                pss.material_attribute_transition mat
                    INNER JOIN pss.material_attribute_definition mad
                        ON mat.material_attribute_definition_id = mad.id
            WHERE
                mat.id = @TransitionId;
        ";
        public static string GetTransitionByData => @"
            SELECT
                mat.id as Id,
                mat.material_attribute_definition_id as MaterialAttributeDefinitionId, 
                mad.name as MaterialAttributeDefinitionName,
                mat.transition_from as From, 
                mat.transition_to as To, 
                mat.classification as Classification, 
                mat.active as Active
            FROM
                pss.material_attribute_transition mat
                    INNER JOIN pss.material_attribute_definition mad
                        ON mat.material_attribute_definition_id = mad.id
            WHERE
                mat.material_attribute_definition_id = @Attribute
                    AND
                mat.transition_from = @From
                    AND
                mat.transition_to = @To
                    AND
                mat.active = true;
        ";
        public static string GetTransitionsByAttributeId => @"
            SELECT
                mat.id as Id,
                mat.material_attribute_definition_id as MaterialAttributeDefinitionId, 
                mad.name as MaterialAttributeDefinitionName,
                mat.transition_from as From, 
                mat.transition_to as To, 
                mat.classification as Classification, 
                mat.active as Active
            FROM
                pss.material_attribute_transition mat
                    INNER JOIN pss.material_attribute_definition mad
                        ON mat.material_attribute_definition_id = mad.id
            WHERE
                mad.id = @MaterialAttributeDefinitionId;
        ";
        public static string AddNewTransition => @"
            INSERT INTO pss.material_attribute_transition(
                material_attribute_definition_id, 
                transition_from, 
                transition_to, 
                classification, 
                active
            )
            VALUES (
                @Attribute, 
                @From, 
                @To, 
                @Classification, 
                @Active
            )
            RETURNING id;
        ";
        public static string UpdateTransition => @"
            UPDATE 
                pss.material_attribute_transition
            SET 
                transition_from = @From,
                transition_to = @To,
                classification = @Classification,
                active = @Active
            WHERE 
                id = @transitionId
        ";
    }
}