/*------------------------------------------------------------------------------------
 CREATE TRIGGERS
 ------------------------------------------------------------------------------------*/

-- application (domain definer)
-- TODO: implement trigger for update

create or replace function ${security_schema}.trigger_after_insert_application()
    returns trigger as $body$
begin
    execute 'insert into ${security_schema}.domain(path, name, domain_type_id) values(''all.' || new.code || ''',''' || new.name ||
                ''', (select id from ${security_schema}.domain_type where code = ''application''))';
    return null;
end
$body$ language plpgsql;

--drop trigger if exists after_insert_application on ${security_schema}.application;
create trigger after_insert_application after insert on ${security_schema}.application
    for each row execute procedure ${security_schema}.trigger_after_insert_application();


create or replace function ${security_schema}.trigger_before_delete_application()
    returns trigger as $body$
begin
    execute 'delete from ${security_schema}.domain where domain_type_id = (select id from ${security_schema}.domain_type where code = ''application'') and name = ''' || old.name || ''';';
    update ${security_schema}.application set deleted_at=now() where id=old.id;
    return null;
end
$body$ language plpgsql;

--drop trigger if exists after_delete_application on ${security_schema}.application;
create trigger before_delete_application before delete on ${security_schema}.application  
    for each row execute procedure ${security_schema}.trigger_before_delete_application();


-- application (domain entity)
-- TODO: implement trigger for update

create or replace function ${security_schema}.trigger_before_insert_application()
    returns trigger as $body$
begin
    new.domain = array[array['all.' || new.code]]::ltree[][];
    return new;
end
$body$ language plpgsql;

--drop trigger if exists before_insert_application on ${security_schema}.application;
create trigger before_insert_application before insert on ${security_schema}.application
    for each row execute procedure ${security_schema}.trigger_before_insert_application();

-- role (domain entity)
-- TODO: implement triggers for delete and update

create or replace function ${security_schema}.trigger_before_insert_role()
    returns trigger as $body$
declare
    domain text;
begin
    execute 'select code from ${security_schema}.application where id =' || new.application_id || ';' into domain;
    new.domain = array[array['all.' || domain]]::ltree[][];
    return new;
end
$body$ language plpgsql;

--drop trigger if exists before_insert_role on ${security_schema}.role;
create trigger before_insert_role before insert on ${security_schema}.role
    for each row execute procedure ${security_schema}.trigger_before_insert_role();


create or replace function ${security_schema}.trigger_before_delete_role()
    returns trigger as $body$
begin
    update ${security_schema}.role set deleted_at=now() where id=old.id;
    return null;
end
$body$ language plpgsql;

--drop trigger if exists before_delete_role on ${security_schema}.role;
create trigger before_delete_role before delete on ${security_schema}.role 
    for each row execute procedure ${security_schema}.trigger_before_delete_role();

/*
-- triggers for tables user and role (=>create db role)
--
create function trigger_after_insert_role()
    returns trigger as $body$
begin
    execute 'create role ' || new.code; -- there is no code in role table yet
    return new;
end
$body$ language plpgsql;

create trigger after_insert_role after insert on ${security_schema}.role
    for each row execute procedure trigger_after_insert_role();
*/


create or replace function ${security_schema}.trigger_before_delete_user()
    returns trigger as $body$
begin
    update ${security_schema}.user set deleted_at=now() where id=old.id;
    return null;
end 
$body$ language plpgsql;

--drop trigger if exists before_delete_user on ${security_schema}.role;
create trigger before_delete_user before delete on ${security_schema}.user 
    for each row execute procedure ${security_schema}.trigger_before_delete_user();


--Triggers to validate if Identity Provider has Sign Up capabilities before setting as default
create or replace function ${security_schema}.trigger_validate_identity_provider()
    returns trigger as $body$
begin
    if (
	    (select has_sign_up 
	    from ${security_schema}.identity_provider_type
	    where id = new.identity_provider_type_id) = false
	    AND 
	    new.is_default = true) 
	 then 
	 	raise exception 'Identity provider % does not have sign up capabilities, thus cannot be the default provider', new.name;
	 else
		return new;
	 end if;
end 
$body$ language plpgsql;

--drop trigger if exists before_insert_identity_provider on ${security_schema}.identity_provider;
create trigger before_insert_identity_provider before insert on ${security_schema}.identity_provider 
    for each row execute procedure ${security_schema}.trigger_validate_identity_provider();

--drop trigger if exists before_update_identity_provider on ${security_schema}.identity_provider;
create trigger before_update_identity_provider before update on ${security_schema}.identity_provider 
    for each row execute procedure ${security_schema}.trigger_validate_identity_provider();


--Triggers to enforce a single default IdP
create or replace function ${security_schema}.trigger_enforce_single_identity_provider()
    returns trigger as $body$
begin
    update ${security_schema}.identity_provider set is_default=false where id <> new.id and new.is_default=true;
    return null;
end 
$body$ language plpgsql;

--drop trigger if exists after_insert_identity_provider on ${security_schema}.identity_provider;
create trigger after_insert_identity_provider after insert on ${security_schema}.identity_provider 
    for each row execute procedure ${security_schema}.trigger_enforce_single_identity_provider();

--drop trigger if exists after_update_identity_provider on ${security_schema}.identity_provider;
create trigger after_update_identity_provider after update on ${security_schema}.identity_provider 
    for each row execute procedure ${security_schema}.trigger_enforce_single_identity_provider();


--Trigger to avoid deletion of the default IdP
create or replace function ${security_schema}.trigger_before_delete_identity_provider()
    returns trigger as $body$
begin
    if old.is_default = true 
    then 	
    	raise exception 'Cannot delete the default identity provider!';
    else
    	return old;
    end if;
end 
$body$ language plpgsql;

--drop trigger if exists before_delete_identity_provider on ${security_schema}.identity_provider;
create trigger before_delete_identity_provider before delete on ${security_schema}.identity_provider 
    for each row execute procedure ${security_schema}.trigger_before_delete_identity_provider();



/* Manages display_order for table application */

create or replace function ${security_schema}.trigger_before_upsert_application()
    returns trigger as $body$
begin
    if TG_OP = 'INSERT' then
        select coalesce(max(display_order), 0) + 1 from ${security_schema}.application a into new.display_order;
    else -- UPDATE
        if (new.display_order <> old.display_order) then
            select (
            coalesce((select display_order from ${security_schema}.application where display_order >= new.display_order order by 1      limit 1), (select max(display_order) + 1 from  ${security_schema}.application)) +
            coalesce((select display_order from ${security_schema}.application where display_order <  new.display_order order by 1 desc limit 1), 0)
            )::real / 2 into new.display_order;
        end if;
    end if;
    return new;
end
$body$ language plpgsql;

create trigger before_upsert_application before insert or update on ${security_schema}.application
    for each row execute procedure ${security_schema}.trigger_before_upsert_application();


-- Triggers for avoiding deletion of entities being used / refered to by other objects

-- create trigger before_delete_constrained_application before delete on ${security_schema}.application
--     for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_contact_info before delete on ${security_schema}.contact_info
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_domain before delete on ${security_schema}.domain
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_domain_item before delete on ${security_schema}.domain_item
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_domain_type before delete on ${security_schema}.domain_type
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_identity_provider before delete on ${security_schema}.identity_provider
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_identity_provider_type before delete on ${security_schema}.identity_provider_type
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_permission before delete on ${security_schema}.permission
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_permission_inheritance before delete on ${security_schema}.permission_inheritance
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_resource_domain_type before delete on ${security_schema}.resource_domain_type
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_resource_type before delete on ${security_schema}.resource_type
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
-- create trigger before_delete_constrained_role before delete on ${security_schema}.role
--     for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_role_permission before delete on ${security_schema}.role_permission
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
-- create trigger before_delete_constrained_user before delete on ${security_schema}.user
--     for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_user_domain before delete on ${security_schema}.user_domain
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
create trigger before_delete_constrained_user_role before delete on ${security_schema}.user_role
    for each row execute procedure ${base_schema}.trigger_before_delete_constrained();
