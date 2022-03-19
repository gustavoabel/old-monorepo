namespace sms_mes_planning_pss_api.Repositories.Queries
{
    public static class UnitSequenceQuery
    {
        public static string Add => @"
      INSERT INTO pss.unit_sequence
        (
          sequence_scenario_version_id, 
          production_unit_id
        )
      VALUES 
        (
            @sequence_scenario_version_id, 
            @production_unit_id
        ) RETURNING id
    ";
        public static string GetById => @"
        SELECT 
            pu.name as ProductionUnitName,
            pu.id as ProductionUnitId,
            put.name as ProductionUnitType,
            us.id as Id,
            ssv.sequence_scenario_id as SequenceScenarioId
        FROM 
            pss.unit_sequence us
                INNER JOIN pss.production_unit pu 
                    ON pu.id = us.production_unit_id
                INNER JOIN pss.production_unit_type put 
                    ON pu.production_unit_type_id = put.id
                INNER JOIN pss.sequence_scenario_version ssv 
                    ON ssv.id = us.sequence_scenario_version_id
        WHERE 
            us.id = @unitSequenceId;
    ";
        public static string GetBySequenceScenarioId => @"
        SELECT pu.name as ProductionUnitName,
          pu.id as ProductionUnitId,
          put.name as ProductionUnitType,
          us.id as Id,
          ssv.sequence_scenario_id as SequenceScenarioId
        FROM pss.unit_sequence us
          INNER JOIN pss.production_unit pu 
            ON pu.id = us.production_unit_id
          INNER JOIN pss.production_unit_type put 
            ON pu.production_unit_type_id = put.id
          INNER JOIN pss.sequence_scenario_version ssv 
            ON ssv.id = us.sequence_scenario_version_id
        WHERE ssv.sequence_scenario_id = @sequenceScenarioId
    ";
        public static string GetCastersBySequenceScenarioId => @"
        SELECT 
            pu.name as ProductionUnitName,
            pu.id as ProductionUnitId,
            put.name as ProductionUnitType,
            us.id as Id,
            ssv.sequence_scenario_id as SequenceScenarioId,
            pulc.max_heat_weight as MaxHeatWeight,
            ssv.Id as SequenceScenarioVersionId
        FROM 
            pss.unit_sequence us
                INNER JOIN pss.production_unit pu 
                    ON pu.id = us.production_unit_id
                INNER JOIN pss.production_unit_type put 
                    ON pu.production_unit_type_id = put.id
                INNER JOIN pss.sequence_scenario_version ssv 
                    ON ssv.id = us.sequence_scenario_version_id
                LEFT JOIN pss.production_unit_limit_configuration pulc 
                    ON pulc.production_unit_id = pu.id 
        WHERE 
            ssv.sequence_scenario_id = @sequenceScenarioId
                and
            lower(put.name) like '%caster%';
    ";
        public static string GetHSMUnitSequenceByCaster => @"
        select 
            us.id as Id, 
            ss.id as SequenceScenarioId, 
            ssv.id as SequenceScenarioVersionId
        from 
            pss.sequence_scenario ss 
                inner join pss.sequence_scenario_version ssv 
                    on ss.id = ssv.sequence_scenario_id 
                inner join pss.unit_sequence us 
                    on ssv.id = us.sequence_scenario_version_id 
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.production_unit_type put 
                    on pu.production_unit_type_id = put.id 
        where 
            ss.id IN (
                select ss2.id
                from pss.sequence_scenario ss2 
                    inner join pss.sequence_scenario_version ssv2 
                        on ss2.id = ssv2.sequence_scenario_id 
                    inner join pss.unit_sequence us2 
                        on ssv2.id = us2.sequence_scenario_version_id
                where
                    us2.id = @UnitSequenceId
            )
                and
            lower(put.name) like '%hsm%';
    ";
        public static string ListHeatsByUnitSequence => @"
        with h as (
            select
                si.id sequenceItemId, 
                si.item_order sequenceItemOrder,
                hg.group_number groupNumber,
                ma.value materialAttributeValue, 
                mad.name materialAttributeName
            from 
                pss.sequence_scenario_version ssv 
                    inner join pss.unit_sequence us 
                        on ssv.id = us.sequence_scenario_version_id 
                    inner join pss.sequence_item si 
                        on us.id = si.unit_sequence_id 
                    inner join pss.input_material im 
                        on si.id = im.sequence_item_id
                    inner join pss.material m 
                        on im.material_id = m.id 
                    inner join pss.material_attribute ma 
                        on m.id = ma.material_id 
                    inner join pss.material_attribute_definition mad 
                        on ma.material_attribute_definition_id = mad.id
                    inner join pss.material_type mt 
                        on mt.id = m.material_type_id
                    inner join pss.heat_group hg
                        on si.heat_group_id = hg.id 
            where 
                us.id = :unitSequenceId and 
                lower(mt.name) like '%heat%'
        )
        select cast(
	        jsonb_set(
	            jsonb_set(
	                jsonb_set(
	                    jsonb_object_agg(h.materialAttributeName, h.materialAttributeValue),
	                    '{sequenceItemOrder}', 
	                    concat('', h.sequenceItemOrder, '')::jsonb, 
	                    true
	                ),
	                '{sequenceItemId}', 
	                concat('', h.sequenceItemId, '')::jsonb,
	                true
	            ),
                '{groupNumber}', 
                concat('', h.groupNumber, '')::jsonb,
                true) as json
        ) as data
        from h
        group by h.groupNumber, h.sequenceItemId, h.sequenceItemOrder
        order by h.groupNumber, h.sequenceItemId;
    ";
        public static string NewSequenceItemOrder => @"
        select 
            max(si.item_order) + 1 as newSequenceOrder
        from 
            pss.unit_sequence us 
                inner join pss.sequence_item si 
                    on us.id = si.unit_sequence_id
        where 
            us.id = @unitSequenceId
    ";
        public static string GetLastItemOrder => @"
        select COALESCE(max(si.item_order),0) as LastSequenceOrder
          from pss.unit_sequence us 
    inner join pss.sequence_item si 
            on us.id = si.unit_sequence_id
         where us.id = @unitSequenceId            
    ";
        public static string GetLastItemOfCaster => @"
        select 
            si.id as HSMSequenceItemId,
            si.item_order as HSMSequenceItemOrder,
            us2.id as CasterUnitSequenceId
        from pss.unit_sequence us 
            inner join pss.sequence_item si 
                on us.id = si.unit_sequence_id 
            inner join pss.input_material im
                on si.id = im.sequence_item_id 
            inner join pss.output_material om 
                on im.material_id = om.material_id 
            inner join pss.sequence_item si2 
                on om.sequence_item_id = si2.id 
            inner join pss.unit_sequence us2 
                on si2.unit_sequence_id = us2.id 
        where 
            us.id = @hsmUnitSequenceId
                and
            us2.id = @casterUnitSequenceId
                and
            us.sequence_scenario_version_id = us2.sequence_scenario_version_id
        order by si.item_order desc
        limit 1;
    ";
        public static string GetLastItemOfDifferentCaster => @"
        select 
            si.id as HSMSequenceItemId,
            si.item_order as HSMSequenceItemOrder,
            us2.id as CasterUnitSequenceId
        from pss.unit_sequence us 
            inner join pss.sequence_item si 
                on us.id = si.unit_sequence_id 
            inner join pss.input_material im
                on si.id = im.sequence_item_id 
            inner join pss.output_material om 
                on im.material_id = om.material_id 
            inner join pss.sequence_item si2 
                on om.sequence_item_id = si2.id 
            inner join pss.unit_sequence us2 
                on si2.unit_sequence_id = us2.id 
        where 
            us.id = @hsmUnitSequenceId
                and
            us2.id != @casterUnitSequenceId
                and
            us.sequence_scenario_version_id = us2.sequence_scenario_version_id
        order by si.item_order desc
        limit 1;
    ";
        public static string NewOutputOrder => @"
        select 
            max(om.material_order) + 1 as newMaterialOrder
        from 
            pss.sequence_item si 
                inner join pss.output_material om 
                    on si.id = om.sequence_item_id
        where 
            si.id = @sequenceItemId
    ";
        public static string AddInputMaterial => @"
        insert into pss.input_material (sequence_item_id, material_id, material_order) 
        values (@sequenceItemId, @materialId, @materialOrder);
    ";
        public static string AddOutputMaterial => @"
        insert into pss.output_material (sequence_item_id, material_id, material_order) 
        values (@sequenceItemId, @materialId, @materialOrder);
    ";
        public static string GetCasterMasterialList => @"
        with c as (
            select 
                pu.name as productionUnitName,
                si.id as sequenceItemId, 
                si.item_order as sequenceItemOrder,
                m.id as inputMaterialId,
                mad.id as materialAttributeDefId,
                mt.name as materialTypeName,
                hg.group_number as heatGroupNumber,
                case
                    when mad.uom = 'text' then mad.name 
                    else concat(mad.name, ' (', mad.uom, ')')
                end as materialAttributeName, 
                ma.value as materialAttributeValue
            from pss.unit_sequence us 
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.sequence_item si 
                    on us.id = si.unit_sequence_id 
                inner join pss.input_material im 
                    on si.id = im.sequence_item_id 
                inner join pss.material m 
                    on im.material_id = m.id 
                inner join pss.material_attribute ma 
                    on m.id = ma.material_id 
                inner join pss.material_attribute_definition mad 
                    on ma.material_attribute_definition_id = mad.id 
                inner join pss.material_type mt 
                    on mad.material_type_id = mt.id
                inner join pss.heat_group hg 
                    on si.heat_group_id = hg.id 
            where us.id = @unitSequenceId
            order by si.item_order, hg.group_number 
        ),
        i as (
            select c.heatGroupNumber, c.sequenceItemId, c.sequenceItemOrder, cast(
                jsonb_set(
                    jsonb_object_agg(
                    c.materialAttributeName, 
                        c.materialAttributeValue
                    ), 
                    '{material_id}', 
                    concat('', c.inputMaterialId, '')::jsonb, 
                    true
                )  || ( '{ ""sequenceItemId"": ""' || c.sequenceItemId || '"",""type"": ""' || c.materialTypeName || '"", ""productionUnitName"": ""' || c.productionUnitName ||'"", ""position"": ""' || c.sequenceItemOrder || '""}')::jsonb as json
            ) as inputMaterial
            from c
            group by c.heatGroupNumber, c.sequenceItemId, c.sequenceItemOrder, c.inputMaterialId, c.materialTypeName, c.productionUnitName
            order by c.sequenceItemOrder
        ),
        h as (
            select i.heatGroupNumber, i.sequenceItemId as sequenceItemId, i.sequenceItemOrder, cast(
                jsonb_set(
                    jsonb_object_agg(
                    case
                        when mad.uom = 'text' then mad.name 
                        else concat(mad.name, ' (', mad.uom, ')')
                    end, 
                        ma.value
                    ),
                    '{material_id}',
                    concat('', m.id, '')::jsonb,
                    true
                ) || ( '{ ""type"": ""' || mt.name || '"", ""sequenceItemId"": ""' || i.sequenceItemId ||'"", ""position"": ""' || i.sequenceItemOrder || '.' || om.material_order ||'""}')::jsonb as json
            ) as outputMaterial
            from i
                inner join pss.output_material om 
                    on i.sequenceItemId = om.sequence_item_id
                inner join pss.material m 
                    on om.material_id = m.id 
                inner join pss.material_attribute ma 
                    on m.id = ma.material_id 
                inner join pss.material_attribute_definition mad 
                    on ma.material_attribute_definition_id = mad.id 
                inner join pss.material_type mt 
                    on mad.material_type_id = mt.id
            group by i.heatGroupNumber, i.sequenceItemId, i.sequenceItemOrder, om.material_order, m.id, mt.name
            order by i.sequenceItemOrder
        ),
        j as (
            select h.heatGroupNumber, h.sequenceItemId, 
            json_build_object(
                '_children', array_agg(h.outputMaterial)
            ) as outputMaterial
            from h
            group by h.heatGroupNumber, h.sequenceItemId, h.sequenceItemOrder
            order by h.sequenceItemOrder
        ),
        k as (
            select i.heatGroupNumber, cast(i.inputMaterial::jsonb || j.outputMaterial::jsonb as json) as data
	          from i inner join j on i.sequenceItemId = j.sequenceItemId
        ),  
        l as (
            select k.heatGroupNumber, 
            json_build_object(
                '_children', array_agg(k.data)
            ) as jsonData
            from k
            group by k.heatGroupNumber
            order by k.heatGroupNumber
        )   
        select cast( 
    		l.jsonData::jsonb || ( '{ ""type"": ""Heat Group ' || l.heatGroupNumber || '"", ""HEAT_GROUP_WEIGHT"": 0, ""STEEL_GRADE_INT"": 0, ""position"": ""' || l.heatGroupNumber ||'""}')::jsonb as json 
		) as data
        from l order by l.heatGroupNumber
    ";
        public static string GetHSMMasterialList => @"
        with c as (
            select 
                pu2.name as input_production_unit_name,
                si.id as sequence_item_id, 
                si.item_order as sequence_item_order,
                m.id as input_material_id,
                concat(si2.item_order, '.', om2.material_order) as input_material_order
            from pss.unit_sequence us 
                inner join pss.sequence_scenario_version ssv 
                    on us.sequence_scenario_version_id = ssv.id
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.sequence_item si 
                    on us.id = si.unit_sequence_id 
                inner join pss.input_material im 
                    on si.id = im.sequence_item_id 
                inner join pss.material m 
                    on im.material_id = m.id 
                inner join pss.output_material om2
                    on m.id = om2.material_id
                inner join pss.sequence_item si2 
                    on om2.sequence_item_id = si2.id
                inner join pss.unit_sequence us2 
                    on si2.unit_sequence_id = us2.id
                inner join pss.sequence_scenario_version ssv2 
                    on us2.sequence_scenario_version_id = ssv2.id and ssv.sequence_scenario_id = ssv2.sequence_scenario_id 
                inner join pss.production_unit pu2 
                    on us2.production_unit_id = pu2.id
            where us.id = :unitSequenceId
            order by si.item_order
        ),
        i as (
            select c.sequence_item_id, c.sequence_item_order, cast(
                jsonb_build_object(
			        'sequenceItemId', c.sequence_item_id,
                    'position', c.sequence_item_order,
                    'caster', c.input_production_unit_name,
                    'slab_position', c.input_material_order
                ) as json
            ) as inputMaterial
            from c
            order by c.sequence_item_order
        ),
        h as (
            select i.sequence_item_id, cast(
                jsonb_set(
                    jsonb_object_agg(
                        case
                            when mad.uom = 'text' then mad.name 
                            else concat(mad.name, ' (', mad.uom, ')')
                        end, 
                        ma.value
                    ),
                    '{material_id}',
                    concat('', m.id, '')::jsonb,
                    true
                ) || ( '{ ""type"": ""' || mt.name || '""}')::jsonb  as json
            ) as outputMaterial
            from i 
                inner join pss.output_material om 
                    on i.sequence_item_id = om.sequence_item_id
                inner join pss.material m 
                    on om.material_id = m.id 
                inner join pss.material_attribute ma 
                    on m.id = ma.material_id 
                inner join pss.material_attribute_definition mad 
                    on ma.material_attribute_definition_id = mad.id 
                inner join pss.material_type mt 
                    on mad.material_type_id = mt.id
            group by i.sequence_item_id, i.sequence_item_order, m.id, mt.name
	        order by i.sequence_item_order
        )
        select cast(
            i.inputMaterial::jsonb || h.outputMaterial::jsonb as json
        ) as data
        from i inner join h on i.sequence_item_id = h.sequence_item_id
    ";
        public static string GetInputMaterialList => @"
        with c as (
            select 
                pu.name as productionUnitName,
                si.id as sequenceItemId, 
                si.item_order as sequenceItemOrder,
                im.material_order as inputMaterialOrder,
                m.id as inputMaterialId,
                mad.id as materialAttributeDefId,
                mt.name as materialTypeName, 
                mad.name as materialAttributeName, 
                ma.value as materialAttributeValue
            from pss.unit_sequence us 
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.sequence_item si 
                    on us.id = si.unit_sequence_id 
                inner join pss.input_material im 
                    on si.id = im.sequence_item_id 
                inner join pss.material m 
                    on im.material_id = m.id 
                inner join pss.material_attribute ma 
                    on m.id = ma.material_id 
                inner join pss.material_attribute_definition mad 
                    on ma.material_attribute_definition_id = mad.id 
                inner join pss.material_type mt 
                    on mad.material_type_id = mt.id
            where us.id = :unitSequenceId
            order by si.item_order
        )
        select 
            cast(
                jsonb_set(
                    jsonb_object_agg(
                        c.materialAttributeName, 
                        c.materialAttributeValue
                    ), 
                    '{material_id}', 
                    concat('', c.inputMaterialId, '')::jsonb, 
                    true
                )  || ( '{ ""sequenceItemId"": ""' || c.sequenceItemId || '"",""type"": ""' || c.materialTypeName || '"", ""productionUnitName"": ""' || c.productionUnitName ||'"", ""position"": ""' || c.sequenceItemOrder || '""}')::jsonb as json
            ) as data
        from c
        group by c.sequenceItemId, c.inputMaterialId, c.materialTypeName, c.productionUnitName, c.sequenceItemOrder, c.inputMaterialOrder
        order by c.sequenceItemOrder, c.inputMaterialOrder
    ";
        public static string GetOutputMaterialList => @"
        with c as (
            select 
                pu.name as productionUnitName,
                si.id as sequenceItemId, 
                si.item_order as sequenceItemOrder,
                om.material_order as inputMaterialOrder,
                m.id as inputMaterialId,
                mad.id as materialAttributeDefId,
                mt.name as materialTypeName, 
                mad.name as materialAttributeName, 
                ma.value as materialAttributeValue
            from pss.unit_sequence us 
                inner join pss.production_unit pu 
                    on us.production_unit_id = pu.id 
                inner join pss.sequence_item si 
                    on us.id = si.unit_sequence_id 
                inner join pss.output_material om 
                    on si.id = om.sequence_item_id 
                inner join pss.material m 
                    on om.material_id = m.id 
                inner join pss.material_attribute ma 
                    on m.id = ma.material_id 
                inner join pss.material_attribute_definition mad 
                    on ma.material_attribute_definition_id = mad.id 
                inner join pss.material_type mt 
                    on mad.material_type_id = mt.id
            where us.id = @unitSequenceId
            order by si.item_order
        )
        select 
            cast(
                jsonb_set(
                    jsonb_object_agg(
                        c.materialAttributeName, 
                        c.materialAttributeValue
                    ), 
                    '{material_id}', 
                    concat('', c.inputMaterialId, '')::jsonb, 
                    true
                )  || ( '{ ""sequenceItemId"": ""' || c.sequenceItemId || '"",""type"": ""' || c.materialTypeName || '"", ""productionUnitName"": ""' || c.productionUnitName ||'"", ""position"": ""' || c.sequenceItemOrder || '""}')::jsonb as json
            ) as data
        from c
        group by c.sequenceItemId, c.inputMaterialId, c.materialTypeName, c.productionUnitName, c.sequenceItemOrder, c.inputMaterialOrder
        order by c.sequenceItemOrder, c.inputMaterialOrder
    ";
        public static string GetSumOfAttributes => @"
            with c as (
                select
                    mad.name as AttributeName,
                    sum(ma.value::decimal) as SumOfAttributeValue
                from 
                    pss.unit_sequence us 
                        inner join pss.sequence_scenario_version ssv on us.sequence_scenario_version_id = ssv.id 
                        inner join pss.production_unit pu on us.production_unit_id = pu.id 
                        inner join pss.sequence_item si on us.id = si.unit_sequence_id 
                        inner join pss.output_material om on si.id = om.sequence_item_id 
                        inner join pss.material m on om.material_id = m.id 
                        inner join pss.material_attribute ma on m.id = ma.material_id 
                        inner join pss.material_attribute_definition mad on ma.material_attribute_definition_id = mad.id 
                where 
                    pu.name = (@unitSequenceName)::text
                        and
                    ssv.sequence_scenario_id = @scenarioId
                        and
                    (
                        lower(mad.name) like '%weight_aim%'
                            or
                        lower(mad.name) like '%length_aim%'
                    )
                group by mad.id
                order by mad.name
            )
            select
                cast (
                    jsonb_object_agg(
                        case
                            when 
                                lower(c.AttributeName) like '%weight_aim%' then 'SumOfWeight' 
                            else 'SumOfLength'
                        end,
                        round(c.SumOfAttributeValue::decimal, 2 )
                    ) as json
                ) as data
            from c;
        ";
    }
}