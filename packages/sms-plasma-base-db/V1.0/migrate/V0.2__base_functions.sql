/*------------------------------------------------------------------------------------
 CREATE FUNCTIONS/PROCEDURES
 ------------------------------------------------------------------------------------*/

create or replace function ${base_schema}.process_fks(sn text, tn text, hs hstore)
returns hstore
as $body$
declare
	r record;
    fk_name text;
    foreign_name_sql text;
    foreign_name text;
begin
	for r in (
        with a as ( select sn schema_name, tn table_name, (each(hs)).* )
        select a.schema_name, a.table_name, a.key as fk_column, a.value as fk_value, f.foreign_table_schema, f.foreign_table_name, f.foreign_column_name
        from a join ${base_schema}.foreign_keys f on f.table_schema = a.schema_name and f.table_name = a.table_name and f.column_name = a.key
    )
	loop
        select tc.name_query
        into foreign_name_sql
        from ${base_schema}.table_config tc
        where tc.schema_name = r.foreign_table_schema and tc.table_name = r.foreign_table_name;

        if foreign_name_sql is not null and r.fk_value is not null then
       		foreign_name_sql := format(foreign_name_sql, r.fk_value);
       	else
	        select column_name
            into fk_name
            from information_schema.columns
	        where table_schema = r.foreign_table_schema and table_name = r.foreign_table_name and (column_name = 'name' or column_name = 'code') limit 1;

	        if (fk_name is not null and r.fk_value is not null) then
	        	foreign_name_sql := format('select %s from %s.%s where %s = %s',
	        		fk_name, r.foreign_table_schema, r.foreign_table_name, r.foreign_column_name, r.fk_value);
	        end if;
       	end if;

        if (foreign_name_sql is not null and r.fk_value is not null) then
        	execute foreign_name_sql into foreign_name;
	        hs := hs || format('"%s"=>"%s (%s)"', r.fk_column, r.fk_value, foreign_name)::hstore;
        end if;
	end loop;
	return hs;
end;
$body$
language plpgsql;



create or replace function ${base_schema}.trigger_before_delete_constrained()
    returns trigger as $$
declare
	r record;
	q record;
	error_json jsonb = '{"message": "foreignKeysReferences", "errors": []}';
	table_json jsonb;
	i integer;
	j integer;
	has_contraints boolean = false;
begin
	i = 0;
	for r in
		select * from  ${base_schema}.foreign_key_contraints
		where lower(f_table_schema) = lower(TG_TABLE_SCHEMA) and lower(f_table_name) = lower(TG_TABLE_NAME) and delete_rule not in ('CASCADE', 'SET NULL', 'SET DEFAULT')
	loop

		table_json = format('{"table": "%s", "rows": []}', r.table_name)::jsonb;

		j = 0;
		for q in execute format ('select * from %s.%s where %s = %s', r.table_schema, r.table_name, r.column_name, old.id)
		loop
			table_json = jsonb_insert(table_json, format('{rows, %s}', j)::text[], hstore_to_json(${base_schema}.process_fks(r.table_schema, r.table_name, hstore(q)))::jsonb);
			j = j + 1;
			has_contraints = true;
		end loop;

		if (j > 0) then
			error_json = jsonb_insert(error_json, format('{errors, %s}', i)::text[], table_json);
		end if;
		i = i + 1;

	end loop;

	if (has_contraints) then
		raise exception '%', jsonb_pretty(jsonb_strip_nulls(error_json));
	else
		return old;
	end if;
end
$$ language plpgsql;



-- creates function and trigger to manage tables with display_order field
--
create or replace function ${base_schema}.ordered_table(sn text, tn text, id_field text)
    returns void as $body$
begin
    execute format(
        '
        create or replace function %1$s.trigger_before_upsert_%2$s()
            returns trigger as $T2$
        begin
            if TG_OP = ''INSERT'' then
                select coalesce(max(display_order), 0) + 1 from %1$s.%2$s t where t.%3$s = new.%3$s into new.display_order;
            else -- UPDATE
                if (new.display_order <> old.display_order) then
                    select (
                    coalesce((select display_order from %1$s.%2$s where display_order >= new.display_order and %3$s = new.%3$s order by 1 limit 1), (select max(display_order) + 1 from %1$s.%2$s where %3$s = new.%3$s)) +
                    coalesce((select display_order from %1$s.%2$s where display_order <  new.display_order and %3$s = new.%3$s order by 1 desc limit 1), 0)
                    )::real / 2 into new.display_order;
                end if;
            end if;
            return new;
        end
        $T2$ language plpgsql;
        ',
        sn, tn, id_field
    );

    execute format(
        '
        create trigger before_upsert_%2$s before insert or update on %1$s.%2$s
        for each row execute procedure %1$s.trigger_before_upsert_%2$s();
        ',
        sn, tn
    );
end
$body$ language plpgsql;
