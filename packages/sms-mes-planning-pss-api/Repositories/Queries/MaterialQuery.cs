namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class MaterialQuery
    {
        public static string ListAvailableMaterialsToAdd(string planningHorizonQuery) => $@"
            with c as (
                select m.id, 
                    mt.id as materialTypeId, 
                    mt.name as materialTypeName, 
                    mad.id as materialAttributeId,
                    mad.name as materialAttributeName,
                    mad.uom as materialAttributeUom,
                    ma.value as materialAttributeValue,
                    ma.min as materialAttributeMinValue,
                    ma.max as materialAttributeMaxValue
                from 
                    pss.unit_sequence us 
                        inner join pss.production_unit pu 
                            on us.production_unit_id = pu.id 
                        inner join pss.production_unit_material_type pumt 
                            on pu.id = pumt.production_unit_id 
                        inner join pss.material_type mt 
                            on pumt.material_type_id = mt.id 
                        inner join pss.material m 
                            on mt.id = m.material_type_id 
                        inner join pss.material_attribute ma 
                            on m.id = ma.material_id 
                        inner join pss.material_attribute_definition mad 
                            on ma.material_attribute_definition_id = mad.id 
                where (us.id = @productionUnitId or @productionUnitId is null)
                  and lower(mt.name) = 'slab'  
                    --Materials which are from the same sequence but another scenario and not already added
                  and m.id in (
                        select scenario_materials.material_id as id
                        from
                        (
                            select im.material_id
                            from 
                                pss.sequence_scenario ss
                                    inner join pss.sequence_scenario_version ssv 
                                        on ssv.sequence_scenario_id = ss.id
                                    inner join pss.unit_sequence us 
                                        on us.sequence_scenario_version_id = ssv.id
                                    inner join pss.sequence_item si 
                                        on si.unit_sequence_id = us.id
                                    inner join pss.input_material im 
                                        on im.sequence_item_id = si.id
                            where 
                                ss.id != @sequenceScenarioId 
                                and ss.group_sequence_id = @groupSequenceId

                            union

                            select om.material_id
                            from 
                                pss.sequence_scenario ss
                                    inner join pss.sequence_scenario_version ssv 
                                        on ssv.sequence_scenario_id = ss.id
                                    inner join pss.unit_sequence us 
                                        on us.sequence_scenario_version_id = ssv.id
                                    inner join pss.sequence_item si 
                                        on si.unit_sequence_id = us.id
                                    inner join pss.output_material om 
                                        on om.sequence_item_id = si.id
                            where 
                                ss.id != @sequenceScenarioId 
                                and ss.group_sequence_id = @groupSequenceId
                        ) scenario_materials
                        where scenario_materials.material_id not in (
                            select 
                                im.material_id
                            from 
                                pss.sequence_scenario ss
                                    inner join pss.sequence_scenario_version ssv 
                                        on ssv.sequence_scenario_id = ss.id
                                    inner join pss.unit_sequence us 
                                        on us.sequence_scenario_version_id = ssv.id
                                    inner join pss.sequence_item si 
                                        on si.unit_sequence_id = us.id
                                    inner join pss.input_material im 
                                        on im.sequence_item_id = si.id
                            where 
                                ss.id = @sequenceScenarioId 
                                and ss.group_sequence_id = @groupSequenceId

                            union

                            select 
                                om.material_id
                            from 
                                pss.sequence_scenario ss
                                    inner join pss.sequence_scenario_version ssv 
                                        on ssv.sequence_scenario_id = ss.id
                                    inner join pss.unit_sequence us 
                                        on us.sequence_scenario_version_id = ssv.id
                                    inner join pss.sequence_item si 
                                        on si.unit_sequence_id = us.id
                                    inner join pss.output_material om 
                                        on om.sequence_item_id = si.id
                            where 
                                ss.id = @sequenceScenarioId 
                                and ss.group_sequence_id = @groupSequenceId
                        )

                        union

                        --Materials not added to any sequence
                        select m.id
                        from 
                            pss.material m
                                left join pss.input_material im 
                                    on m.id = im.material_id
                                left join pss.output_material om 
                                    on m.id = om.material_id
                        where 
                            im.id is null 
                            and om.id is null

                        union

                        --Materials from a deleted sequence
                        select 
                            im.material_id
                        from 
                            pss.group_sequence gs
                                inner join pss.sequence_scenario ss 
                                    on gs.id = ss.group_sequence_id
                                inner join pss.sequence_scenario_version ssv 
                                    on ssv.sequence_scenario_id = ss.id
                                inner join pss.unit_sequence us 
                                    on us.sequence_scenario_version_id = ssv.id
                                inner join pss.sequence_item si 
                                    on si.unit_sequence_id = us.id
                                inner join pss.input_material im 
                                    on im.sequence_item_id = si.id
                        where 
                            gs.planning_status = 'DELETED'

                        union

                        select 
                            om.material_id
                        from 
                            pss.group_sequence gs
                                inner join pss.sequence_scenario ss 
                                    on gs.id = ss.group_sequence_id
                                inner join pss.sequence_scenario_version ssv 
                                    on ssv.sequence_scenario_id = ss.id
                                inner join pss.unit_sequence us 
                                    on us.sequence_scenario_version_id = ssv.id
                                inner join pss.sequence_item si 
                                    on si.unit_sequence_id = us.id
                                inner join pss.output_material om 
                                    on om.sequence_item_id = si.id
                        where 
                            gs.planning_status = 'DELETED'
                    )
                    {planningHorizonQuery}
                order by m.id
            ),
            d as (
                select
                    c.id as slabId,
                    ma2.material_id as coilId,
                    mad.id as coilAttributeId,
                    mad.name as coilAttributeName,
                    ma2.value as coilAttributeValue
                from
                    c
                        inner join pss.material_attribute ma 
                            on c.id <> ma.material_id and c.materialAttributeValue = ma.value 
                        inner join pss.material m 
                            on ma.material_id = m.id 
                        inner join pss.material_type mt 
                            on m.material_type_id = mt.id
                        inner join pss.material_attribute_definition mad 
                            on mt.id = mad.material_type_id 
                        inner join pss.material_attribute ma2 
                            on mad.id = ma2.material_attribute_definition_id and ma2.material_id = m.id
                where
                    lower(c.materialAttributeName) like '%piece%'
                        and
                    lower(mad.name) like '%aim%'
                
            ),
            e as (
                select c.id, cast(
                    jsonb_set(
                        jsonb_object_agg(
                            c.materialAttributeId, 
                            c.materialAttributeValue
                        ), 
                        '{{id}}', 
                        concat('', c.id, '')::jsonb, 
                        true
                    )  || ( '{{ ""0"": ""' || c.materialTypeName || '""}}')::jsonb as json
                ) as slabData
                from c
                group by c.id, c.materialTypeName
                order by c.id
            ),
            f as (
                select d.slabId, cast(
                    jsonb_object_agg(
                            d.coilAttributeId, 
                            d.coilAttributeValue
                    )  as json
                ) as coilData
                from d
                group by d.slabId
                order by d.slabId
            )
            select cast(
                e.slabData::jsonb || f.coilData::jsonb as json
            ) as data
            from 
                e inner join f on e.id = f.slabId
        ";
        public static string GetById => @"
            with c as (
                select 
                    m.id, 
                    mt.id as materialTypeId, 
                    mt.name as materialTypeName, 
                    mad.name as materialAttributeName,
                    mad.uom as materialAttributeUom,
                    ma.value as materialAttributeValue
                from pss.production_unit pu 
                    inner join pss.production_unit_material_type pumt 
                        on pu.id = pumt.production_unit_id 
                    inner join pss.material_type mt 
                        on pumt.material_type_id = mt.id 
                    inner join pss.material m 
                        on mt.id = m.material_type_id 
                    inner join pss.material_attribute ma 
                        on m.id = ma.material_id 
                    inner join pss.material_attribute_definition mad 
                        on ma.material_attribute_definition_id = mad.id 
                where m.id = @MaterialID
            )
            select cast(
                jsonb_set(
                    jsonb_object_agg(
                        c.materialAttributeName, 
                        c.materialAttributeValue
                    ), 
                '{id}', 
                concat('', c.id, '')::jsonb, 
                true
                )  || ( '{ ""type"": ""' || c.materialTypeName || '""}')::jsonb as json
            ) as data
            from c
            group by c.id, c.materialTypeName
            order by c.id;
        ";
        public static string GetByPieceId => @"
            select 
                m.id as Id
            from 
                pss.material m
                    inner join pss.material_attribute ma 
                        on m.id = ma.material_id
                    inner join pss.material_attribute_definition mad 
                        on ma.material_attribute_definition_id = mad.id
            where 
                lower(mad.name) like '%ps_piece_id%'
                    and
                mad.material_type_id = @materialType
                    and
                ma.value = @pieceId;
        ";
        public static string GetOutputMaterialBySequenceItemId => @"
           select om.material_id
             from pss.output_material om 
            where om.sequence_item_id = @sequenceItemId;
        ";
        public static string GetMaterialOrderSendToMES => @"
           select om.material_order
             from pss.output_material om
            where om.sequence_item_id = @sequenceItemId
              and om.material_id      = @materialId;
        ";

        public static string GetMaterialsSendToMES => @"
            SELECT MAX(case when mt.name LIKE '%Slab%' then m.id else null end) slab_id,
            MAX(case when mt.name LIKE '%Coil%' then m.id else null end) coil_id,
            job.ps_piece_id,
            row_to_json(job) as data
            FROM
            crosstab(
            $$
            SELECT materials.piece_id,
            mad.name,
            ma.value
            FROM
            (
                SELECT p.piece_id,
                m.id as material_id
                FROM
                (
                    SELECT ma.value as piece_id
                    FROM pss.material_attribute ma
                    INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
                    INNER JOIN pss.material_type mt ON mt.id = mad.material_type_id
                    WHERE 
                        (mt.name LIKE '%Slab%' or mt.name LIKE '%Coil%')
                    AND
                        (mad.name = 'PS_PIECE_ID')
                    GROUP BY ma.value
                ) as p
                INNER JOIN pss.material_attribute ma ON ma.value = p.piece_id
                INNER JOIN pss.material m ON ma.material_id = m.id
            ) as materials
            INNER JOIN pss.material_attribute ma ON ma.material_id = materials.material_id
            INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
            INNER JOIN pss.material_type mt ON mt.id = mad.material_type_id
            WHERE mad.name != 'PS_PIECE_ID'
            GROUP BY materials.piece_id,
            mad.name,
            ma.value
            ORDER  BY 1, 2
            $$
            ,
            $$ 
                VALUES
                ('PRODUCTION_ORDER_ID'),
                ('PRODUCTION_STEP_ID'),
                ('COIL_THICKNESS_AIM'),
                ('COIL_WIDTH_AIM'),
                ('COIL_LENGTH_AIM'),
                ('COIL_WEIGHT_AIM'),
                ('DURATION'),
                ('REMARK'),
                ('SLAB_THICKNESS_AIM'),
                ('STEEL_DESIGN_CD'),
                ('SLAB_WIDTH_AIM'),
                ('STEEL_GRADE_INT')
            $$
            ) as job (
                PS_PIECE_ID text,
                PRODUCTION_ORDER_ID_TARGET text,
                PRODUCTION_STEP_ID_TARGET text,
                THICKNESS_TARGET text,
                WIDTH_TARGET text,
                LENGTH_TARGET text,
                WEIGHT_TARGET text,
                DURATION text,
                REMARK text,
                SLAB_THICKNESS_TARGET text,
                STEEL_DESIGN_CD text,
                SLAB_WIDTH text,
                STEEL_GRADE_INT text
            )
            INNER JOIN pss.material_attribute ma ON ma.value = job.ps_piece_id
            INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
            INNER JOIN pss.material m ON ma.material_id = m.id
            INNER JOIN pss.material_type mt ON mt.id = mad.material_type_id
            WHERE m.id IN (SELECT UNNEST(:materialIdList))
            GROUP BY job.ps_piece_id,
            job.*
        ";
        public static string GetMaterialsGroupedByPieceId => @"
            SELECT MAX(case when mt.name LIKE '%Slab%' then m.id else null end) slab_id,
            MAX(case when mt.name LIKE '%Coil%' then m.id else null end) coil_id,
            job.piece_id,
            row_to_json(job) as data
            FROM
            crosstab(
            $$
            SELECT materials.piece_id,
            mad.name,
            ma.value
            FROM
            (
                SELECT p.piece_id,
                m.id as material_id
                FROM
                (
                    SELECT ma.value as piece_id
                    FROM pss.material_attribute ma
                    INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
                    INNER JOIN pss.material_type mt ON mt.id = mad.material_type_id
                    WHERE 
                        (mt.name LIKE '%Slab%' or mt.name LIKE '%Coil%')
                    AND
                        (mad.name = 'PS_PIECE_ID')
                    GROUP BY ma.value
                ) as p
                INNER JOIN pss.material_attribute ma ON ma.value = p.piece_id
                INNER JOIN pss.material m ON ma.material_id = m.id
            ) as materials
            INNER JOIN pss.material_attribute ma ON ma.material_id = materials.material_id
            INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
            INNER JOIN pss.material_type mt ON mt.id = mad.material_type_id
            WHERE mad.name != 'PS_PIECE_ID'
            GROUP BY materials.piece_id,
            mad.name,
            ma.value
            ORDER  BY 1, 2
            $$
            ,
            $$ 
                VALUES
                ('CUSTOMER_ORDER_ID'),
                ('CUSTOMER_ORDER_POS'),
                ('PROMISED_DATE_LATEST'),
                ('STEEL_GRADE_INT'),
                ('STEEL_DESIGN_CD'),
                ('SLAB_WIDTH_AIM'),
                ('SLAB_THICKNESS_AIM'),
                ('SLAB_LENGTH_AIM'),
                ('COIL_WIDTH_AIM'),
                ('COIL_THICKNESS_AIM'),
                ('COIL_LENGTH_AIM'),
                ('SLAB_WEIGHT_AIM'),
                ('FLAG_CUMULATIVE_ORDER'),
                ('PRODUCT_TYPE_CD'),
                ('NO_FIRST_SLABS_IND'),
                ('LOW_CU'),
                ('LOW_DRAFT'),
                ('NO_DRAFT'),
                ('ROLL_WEAR_ADJUSTMENT'),
                ('SPEC_INSTRUCT_PRODUCTION'),
                ('PERFORMANCE_DUR'),
                ('PERFORMANCE')
            $$
            ) as job (
                PIECE_ID text,
                CUSTOMER_ORDER_ID text,
                CUSTOMER_ORDER_POS text,
                PROMISED_DATE_LATEST text,
                STEEL_GRADE_ID_INT text,
                STEEL_DESIGN text,
                SLAB_WIDTH_AIM text,
                SLAB_THICKNESS_AIM text,
                SLAB_LENGTH_AIM text,
                COIL_WIDTH_AIM text,
                COIL_THICKNESS_AIM text,
                COIL_LENGTH_AIM text,
                WEIGHT_AIM text,
                FLAG_CUMULATIVE_ORDER text,
                PRODUCT_TYPE_CD text,
                NO_FIRST_SLABS_IND text,
                LOW_CU text,
                LOW_DRAFT text,
                NO_DRAFT text,
                GRADE_ROLL_WEAR text,
                SPEC_INSTRUCT_PRODUCTION text,
                PERFORMANCE_DUR text,
                PERFORMANCE text
            )
            INNER JOIN pss.material_attribute ma ON ma.value = job.piece_id
            INNER JOIN pss.material_attribute_definition mad ON mad.id = ma.material_attribute_definition_id
            INNER JOIN pss.material m ON ma.material_id = m.id
            INNER JOIN pss.material_type mt ON mt.id = mad.material_type_id
            WHERE ma.value IN (SELECT UNNEST(:pieceIdList))
            GROUP BY job.piece_id,
            job.*
        ";
        public static string GetRelatedCoil => @"
            select m.id
            from 
                pss.material m 
                    inner join pss.material_attribute ma 
                        on m.id = ma.material_id 
                    inner join pss.material_attribute_definition mad 
                        on ma.material_attribute_definition_id = mad.id 
                    inner join pss.material_type mt 
                        on mad.material_type_id = mt.id
            where 
                lower(mad.name) like '%piece%'
                    and
                mt.id = 3
                    and
                ma.value = @PieceId
        ";
        public static string AddNewMaterial => @"
            INSERT INTO pss.material(
                weight, 
                is_placeholder, 
                is_internally_calculated, 
                unit_sequence_id, 
                material_type_id
            )
            VALUES (@weight, false, false, null, @materialTypeId)
            RETURNING id;
        ";
        public static string UpdateMaterialWeight => @"
            UPDATE pss.material_attribute
               SET value = @weight
             WHERE material_id = @materialId
               AND material_attribute_definition_id = 1;
        ";
        public static string GetMaterialIdBySequeceItemId => @"
            SELECT im.material_id
              FROM pss.input_material im
             WHERE im.sequence_item_id = @sequenceItemId               
        ";
        public static string GetHeatWeightByMaterialId => @"
            SELECT ma.value
              FROM pss.material_attribute ma
             WHERE ma.material_attribute_definition_id = 1
               AND ma.material_id = @materialId
        ";        
        public static string AddAttributesToNewMaterial => @"
            INSERT INTO pss.material_attribute(
                value, 
                min, 
                max, 
                material_id, 
                material_attribute_definition_id
            )
            VALUES (@value, null, null, @materialId, @materialAttributeId);
        ";
        public static string UpdateAttributesOfMaterial => @"
            UPDATE 
                pss.material_attribute
            SET 
                value=@value
            WHERE 
                material_id = @materialId
                    and
                material_attribute_definition_id = @materialAttributeId;
        ";
        public static string MoveItemToNewPosition => @"
            update
                pss.sequence_item
            set 
                item_order = @itemOrder
            where 
                id = @sequenceItemId;
        ";
        public static string MoveOutputMaterialOnSameItem => @"
            update
                pss.output_material
            set 
                material_order = @itemOrder
            where 
                material_id = @materialId
                and sequence_item_id = @sequenceItemId;
        ";
        public static string MoveOutputMaterialOnDifferentItem => @"
            update
                pss.output_material
            set 
                material_order = @itemOrder,
                sequence_item_id = @sequenceItemId
            where 
                material_id = @materialId
                and sequence_item_id = @oldSequenceItemId;
        ";
        public static string GetItemsFromSameSequence(string where) => $@"
            select 
                si.id,
                si.item_order as ItemOrder,
                si.unit_sequence_id as UnitSequenceId
            from
                pss.sequence_item si
                    inner join pss.unit_sequence us 
                        on si.unit_sequence_id = us.id 
                    inner join pss.sequence_item si2
                        on us.id = si2.unit_sequence_id 
            where
                si2.id = @sequenceItemId
                and si.id <> @sequenceItemId
                {where}
            order by si.item_order ASC;
        ";
        public static string GetOutputMaterialsFromTheSameItem(string where) => $@"
            select 
                om.id as Id,
                om.material_order as ItemOrder,
                om.sequence_item_id as SequenceItemId,
                om.material_id as MaterialId
            from
                pss.output_material om
                    inner join pss.sequence_item si
                        on om.sequence_item_id = si.id 
                    inner join pss.output_material om2 
                        on si.id = om2.sequence_item_id
                    
            where
                om2.material_id = @materialId
                and om.material_id <> @materialId
                {where}
            order by om.material_order ASC;
        ";
        public static string GetOutputMaterialsFromDifferentItem(string where) => $@"
            select 
                om.id as Id,
                om.material_order as ItemOrder,
                om.sequence_item_id as SequenceItemId,
                om.material_id as MaterialId
            from
                pss.output_material om 
            where
                om.sequence_item_id = @sequenceItemId
                {where}
            order by om.material_order ASC;
        ";
        public static string GetLastItemOrder => @"
            select 
                max(si.item_order) as newSequenceOrder
            from 
                pss.sequence_item si
                    inner join pss.unit_sequence us 
                        on si.unit_sequence_id = us.id 
                    inner join pss.sequence_item si2
                        on us.id = si2.unit_sequence_id
            where 
                si2.id = @sequenceItemId
                and si.id <> @sequenceItemId;
        ";
        public static string GetLastOutputOrderFromTheSameItem => @"
            select 
                max(om.material_order) as newOutputOrder
            from 
                pss.output_material om
                    inner join pss.sequence_item si
                        on om.sequence_item_id = si.id 
                    inner join pss.output_material om2 
                        on si.id = om2.sequence_item_id
            where 
                om2.material_id = @materialId
                and om.material_id <> @materialId;
        ";
        public static string GetLastOutputOrderFromDifferentItem => @"
            select 
                max(om.material_order) as newOutputOrder
            from 
                pss.output_material om
            where 
                om.sequence_item_id = @sequenceItemId;
        ";
        public static string CheckIfItsInput => @"
            select
                im.id as Id,
                im.material_order as ItemOrder,
                im.material_id as MaterialId,
                im.sequence_item_id as SequenceItemId
            from
                pss.input_material im
            where
                im.material_id = @materialId
                    and
                im.sequence_item_id = @sequenceItemId;
        ";
        public static string CheckIfItsOutput => @"
            select
                om.id as Id,
                om.material_order as ItemOrder,
                om.material_id as MaterialId,
                om.sequence_item_id as SequenceItemId
            from
                pss.output_material om
            where
                om.material_id = @materialId
                    and
                om.sequence_item_id = @sequenceItemId;
        ";
        public static string CasterSlabByCoilSequenceItem => @"
            select 
                om.id as Id,
                om.material_order as ItemOrder,
                om.material_id as MaterialId,
                om.sequence_item_id as SequenceItemId 
            from
                pss.output_material om 
                    inner join pss.input_material im  
                        on im.material_id = om.material_id
            where
                im.sequence_item_id = @sequenceItemId;
        ";
        public static string HSMSequenceItemBySlab => @"
            select 
                si.id
            from
                pss.input_material im 
                    inner join pss.sequence_item si 
                        on im.sequence_item_id = si.id
                    inner join pss.unit_sequence us 
                        on si.unit_sequence_id = us.id
                    inner join pss.sequence_scenario_version ssv 
                        on us.sequence_scenario_version_id = ssv.id 
            where 
                im.material_id = @materialId
                    and
                ssv.sequence_scenario_id = @sequenceScenarioId;
        ";
        public static string DeleteHSMSequenceItem => @"
            delete from
                pss.output_material om 
            where
                om.sequence_item_id = @hsmSequenceItemId;
                
            delete from
                pss.input_material im 
            where
                im.sequence_item_id = @hsmSequenceItemId;
                
            delete from
                pss.sequence_item si
            where
                si.id = @hsmSequenceItemId;
        ";
        public static string DeleteCasterOutputMaterial => @"
            delete from
                pss.output_material om 
            where
                om.sequence_item_id = @sequenceItemId
                    and
                om.material_id = @materialId;
        ";
        public static string DeleteCasterSequenceItem => @"
            delete from
                pss.input_material im 
            where
                im.sequence_item_id = @sequenceItemId;
                
            delete from
                pss.sequence_item si
            where
                si.id = @sequenceItemId;
        ";
    }
}