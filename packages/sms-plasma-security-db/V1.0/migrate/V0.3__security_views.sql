/*------------------------------------------------------------------------------------
 CREATE VIEWS
 ------------------------------------------------------------------------------------*/

-- user permissions

create or replace view ${security_schema}.user_permission as
with 
user_direct_permission as (
	select u.id as user_id, a.id as application_id, rt.name as resource, p.action
   	from ${security_schema}.user u
    join ${security_schema}.user_role ur on u.id = ur.user_id
    join ${security_schema}.role r on r.id = ur.role_id
    join ${security_schema}.role_permission rp on r.id = rp.role_id
    join ${security_schema}.permission p on p.id = rp.permission_id
    join ${security_schema}.resource_type rt on rt.id = p.resource_type_id
    join ${security_schema}.application a on a.id = r.application_id and a.id = rt.application_id
	where r.status = 'ACTIVE'	
  	group by u.id, a.id, rt.name, p.action
),
user_direct_permission_with_reads as (
	select p.user_id, p.application_id, p.resource, 'READ'::${security_schema}.permission_action as action
  	from user_direct_permission p
  	where p.action = 'WRITE'::${security_schema}.permission_action
	union
	select p.user_id, p.application_id, p.resource, p.action
  	from user_direct_permission p
),
inherited_permission as (
 	select a.id as application_id, r1.name as pr, p1.action as pa, r2.name as cr, p2.action as ca
   	from ${security_schema}.application a
    join ${security_schema}.resource_type r1 on a.id = r1.application_id
    join ${security_schema}.resource_type r2 on a.id = r2.application_id
    join ${security_schema}.permission p1 on p1.resource_type_id = r1.id
    join ${security_schema}.permission p2 on p2.resource_type_id = r2.id
    join ${security_schema}.permission_inheritance pi on pi.parent_permission_id = p1.id and pi.child_permission_id = p2.id
),
inherited_permission_with_reads as (
	select p.application_id, p.pr, p.pa, p.cr, 'READ'::${security_schema}.permission_action as ca
  	from inherited_permission p
  	where p.ca = 'WRITE'::${security_schema}.permission_action
	union
	select p.application_id, p.pr, 'READ'::${security_schema}.permission_action as pa, p.cr, 'READ'::${security_schema}.permission_action as ca
  	from inherited_permission p
  	where p.pa = 'WRITE'::${security_schema}.permission_action
	union
	select p.application_id, p.pr, p.pa, p.cr, p.ca
  	from inherited_permission p
),
recursive_inherited_permission as (
	with recursive inherited (pr, pa, cr, ca) as (
		select pr, pa, cr, ca
	    from inherited_permission_with_reads
	  	union all
	    select i.pr, i.pa, ip.cr, ip.ca
	    from inherited i
	    join inherited_permission_with_reads ip on (i.cr = ip.pr and i.ca = ip.pa)
	) 
	select distinct pr, pa, cr, ca from inherited
),
unified as (
	select * 
	from user_direct_permission_with_reads d
	union
	select d.user_id, d.application_id, i.cr as resource, i.ca as action 
	from user_direct_permission_with_reads d
	join recursive_inherited_permission i on d.resource = i.pr and d.action = i.pa
)
select distinct * from unified;


-- narrowed user permissions (permissions with domain constraints)

create or replace view ${security_schema}.narrowed_user_permission as
with pt as (
select distinct 
	up.user_id,
	up.application_id,
	(
	quote_ident(up.resource || ':' || up.action) || 
	'=>{{' || case when domain_type_id is null then ''	else string_agg(ltree2text(ud.path), '},{')	end || '}}'
	) as permissions
from
	${security_schema}.user_permission up,
	(select ud.user_id, d.path
		from ${security_schema}.user_domain ud, ${security_schema}.domain_item di, ${security_schema}.domain d
		where
		    di.user_domain_id = ud.id
		    and di.domain_id = d.id
	) as ud,
	(select rt.application_id, rt.name, rt.id, dt.domain_type_id
		from ${security_schema}.resource_type rt left join ${security_schema}.resource_domain_type dt on rt.id = dt.resource_type_id 
	) as rt
where
    up.resource = rt.name
    and (ud.user_id = up.user_id or rt.domain_type_id is null)
    and up.application_id = rt.application_id
group by up.user_id, up.application_id, up.resource, up.action, rt.domain_type_id
order by up.user_id
)
select pt.user_id, pt.application_id, string_agg(pt.permissions, ',')::hstore as permissions
from pt
group by pt.user_id, pt.application_id;

