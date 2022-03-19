/**
 * Test suite for antlr4 parser
 */

import { buildSql, Handler } from '@sms/plasma-nodejs-api';
import { expect } from 'chai';

import handlers from '../src/handlers';

const expectation = (request: string, expected: string, handler: Handler) => {
  const sql = buildSql(request, handler);
  expect(sql).to.equal(expected);
};

describe('SQL Generation Tests', () => {
  describe('Query endpoint', () => {
    const handler = handlers.find((h) => h.endpoint === 'query') as Handler;

    it('With spaces', () =>
      expectation(
        "/rex/asset?select='asset'.id,    name",
        'select "asset".id,"asset".name from rex."asset" "asset"',
        handler,
      ));

    it('Single table, no filter', () =>
      expectation('/rex/asset?select=id,name', 'select "asset".id,"asset".name from rex."asset" "asset"', handler));

    it('Single table, no filter, limit', () =>
      expectation(
        '/rex/asset?select=id,name&limit=10',
        'select "asset".id,"asset".name from rex."asset" "asset" limit 10',
        handler,
      ));

    it('Single table, aliased', () =>
      expectation("/rex/'a':asset?select=id,name", 'select "a".id,"a".name from rex."asset" "a"', handler));

    it('Single join', () =>
      expectation(
        "/vero/'a':agent?include='b':agent_bundle[id=bundle_id]&select=id,name,'bundle':'b'.name",
        'select "a".id,"a".name,"b".name as "bundle" from vero."agent" "a" inner join vero."agent_bundle" "b" on ("b".id = "a".bundle_id)',
        handler,
      ));

    it('Single join, keys aliased', () =>
      expectation(
        "/vero/'a':agent?include='b':agent_bundle['b'.id='a'.bundle_id]&select=id,name,'bundle':'b'.name",
        'select "a".id,"a".name,"b".name as "bundle" from vero."agent" "a" inner join vero."agent_bundle" "b" on ("b".id = "a".bundle_id)',
        handler,
      ));

    it('Single join, without alias', () =>
      expectation(
        "/vero/agent?include=agent_bundle[id=bundle_id]&select=id,name,'bundle':'agent_bundle'.name",
        'select "agent".id,"agent".name,"agent_bundle".name as "bundle" from vero."agent" "agent" inner join vero."agent_bundle" "agent_bundle" on ("agent_bundle".id = "agent".bundle_id)',
        handler,
      ));

    it('Single join with schemas', () =>
      expectation(
        "/vero/'a':agent?include='b':s1.agent_bundle[id=bundle_id]&select=id,name,'bundle':'b'.name",
        'select "a".id,"a".name,"b".name as "bundle" from vero."agent" "a" inner join s1."agent_bundle" "b" on ("b".id = "a".bundle_id)',
        handler,
      ));

    it('Single join with default join type', () =>
      expectation(
        "/vero/'a':agent?include='b':agent_bundle[id=bundle_id]&select=id,name,'bundle':'b'.name",
        'select "a".id,"a".name,"b".name as "bundle" from vero."agent" "a" inner join vero."agent_bundle" "b" on ("b".id = "a".bundle_id)',
        handler,
      ));

    it('Single join with join type', () =>
      expectation(
        "/vero/'a':agent?include='b':agent_bundle[id=bundle_id, full]&select=id,name,'bundle':'b'.name",
        'select "a".id,"a".name,"b".name as "bundle" from vero."agent" "a" full join vero."agent_bundle" "b" on ("b".id = "a".bundle_id)',
        handler,
      ));

    it('Single join with join type and ltree filter', () =>
      expectation(
        "/rex/'ctp':composed_thing_profile?select='ctp'.thing_id&include='t':rex.thing['ctp'.thing_id='t'.id]&where=and('t'.path<@'1.4', 'ctp'.profile_id=217)",
        'select "ctp".thing_id from rex."composed_thing_profile" "ctp" inner join rex."thing" "t" on ("ctp".thing_id = "t".id) where "t".path <@ \'1.4\' and "ctp".profile_id = (217)::numeric',
        handler,
      ));

    it('Single join with schemas and join type', () =>
      expectation(
        "/vero/'a':agent?include='b':s1.agent_bundle[id=bundle_id, left]&select=id,name,'bundle':'b'.name",
        'select "a".id,"a".name,"b".name as "bundle" from vero."agent" "a" left join s1."agent_bundle" "b" on ("b".id = "a".bundle_id)',
        handler,
      ));

    it('Single join with schemas and default join type', () =>
      expectation(
        "/ts/'a':field?include='b':uom.unit['b'.id='a'.unit_id]&select=id,name,type,description,aggregator,is_key,is_unique,is_required,order_position,'unit_id':'b'.id,'unit':'b'.name,'symbol':'b'.symbol&where=data_type_id=1&orderby=9",
        'select "a".id,"a".name,"a".type,"a".description,"a".aggregator,"a".is_key,"a".is_unique,"a".is_required,"a".order_position,"b".id as "unit_id","b".name as "unit","b".symbol as "symbol" from ts."field" "a" inner join uom."unit" "b" on ("b".id = "a".unit_id) where "a".data_type_id = (1)::numeric order by 9',
        handler,
      ));

    it('Multiple joins', () =>
      expectation(
        "/vero/'a':agent?include='b':agent_bundle[id=bundle_id],'t':tenant[id=tenant_id]&select='tenant':'t'.name,name,'bundle':'b'.name",
        'select "t".name as "tenant","a".name,"b".name as "bundle" from vero."agent" "a" inner join vero."agent_bundle" "b" on ("b".id = "a".bundle_id) inner join vero."tenant" "t" on ("t".id = "a".tenant_id)',
        handler,
      ));

    it('Multiple joins, nested', () =>
      expectation(
        "/vero/'a':agent?include='b':agent_bundle[id=bundle_id]('t':tenant[id=tenant_id])&select='tenant':'t'.name,name,'bundle':'b'.name",
        'select "t".name as "tenant","a".name,"b".name as "bundle" from vero."agent" "a" inner join vero."agent_bundle" "b" on ("b".id = "a".bundle_id) inner join vero."tenant" "t" on ("t".id = "b".tenant_id)',
        handler,
      ));

    it('Arrow column', () =>
      expectation(
        "/vero/agent?select=id,params->'server'",
        'select "agent".id,"agent".params->\'server\' from vero."agent" "agent"',
        handler,
      ));

    it('Array column', () =>
      expectation(
        '/vero/agent?select=id,params[0]',
        'select "agent".id,"agent".params[0] from vero."agent" "agent"',
        handler,
      ));

    it('Select constant, decimal', () =>
      expectation("/vero/'a':agent?select=id,3", 'select "a".id,3 from vero."agent" "a"', handler));

    it('Select constant, negative decimal', () =>
      expectation("/vero/'a':agent?select=-3", 'select -3 from vero."agent" "a"', handler));

    it('Select constant, boolean', () =>
      expectation("/vero/'a':agent?select=id,true", 'select "a".id,true from vero."agent" "a"', handler));

    it('Select math expression', () =>
      expectation(
        "/vero/'a':agent?select=id,2+3",
        'select "a".id,(2)::numeric + (3)::numeric from vero."agent" "a"',
        handler,
      ));

    it('Function call, constant argument', () =>
      expectation(
        "/vero/'a':agent?select=id,sum(1)",
        'select "a".id,sum(cast((1) as numeric)) from vero."agent" "a"',
        handler,
      ));

    it('Function call, column argument', () =>
      expectation(
        "/vero/'a':agent?select=id,avg(params[0])",
        'select "a".id,avg(cast(("a".params[0]) as numeric)) from vero."agent" "a"',
        handler,
      ));

    it('Function call, expression argument', () =>
      expectation(
        "/vero/'a':agent?select=id,avg(params[0]+params[1])",
        'select "a".id,avg(cast(("a".params[0] + "a".params[1]) as numeric)) from vero."agent" "a"',
        handler,
      ));

    it('Function call, expression argument with constant', () =>
      expectation(
        "/vero/'a':agent?select=id,avg(params[0]-3)",
        'select "a".id,avg(cast(("a".params[0] - (3)::numeric) as numeric)) from vero."agent" "a"',
        handler,
      ));

    it('Boolean filter', () =>
      expectation(
        "/vero/'a':agent?select=name&where=true",
        'select "a".name from vero."agent" "a" where true',
        handler,
      ));

    it('Simple filter', () =>
      expectation(
        "/vero/'a':agent?select=name&where=and(status='active',tenant=1)",
        'select "a".name from vero."agent" "a" where "a".status = \'active\' and "a".tenant = (1)::numeric',
        handler,
      ));

    it('Simple Null filter', () =>
      expectation(
        "/vero/'a':agent?select=name&where=isnull(status)",
        'select "a".name from vero."agent" "a" where "a".status isnull',
        handler,
      ));

    it('Null filter', () =>
      expectation(
        "/vero/'a':agent?select=name&where=and(isnull(status),tenant=1)",
        'select "a".name from vero."agent" "a" where "a".status isnull and "a".tenant = (1)::numeric',
        handler,
      ));

    it('Simple Not Null filter', () =>
      expectation(
        "/vero/'a':agent?select=name&where=isnotnull(status)",
        'select "a".name from vero."agent" "a" where "a".status notnull',
        handler,
      ));

    it('Not Null filter', () =>
      expectation(
        "/vero/'a':agent?select=name&where=and(isnotnull(status),tenant=1)",
        'select "a".name from vero."agent" "a" where "a".status notnull and "a".tenant = (1)::numeric',
        handler,
      ));

    it('Select distinct equipment dimension', () =>
      expectation(
        "/olap/costing?select=distinct('equipment':equipment->'equipment')",
        'select distinct "costing".equipment->\'equipment\' as "equipment" from olap."costing" "costing"',
        handler,
      ));

    it('Select group by one field', () =>
      expectation(
        "/olap/costing?select='site':equipment->'site','mass':sum(measures->'mass')&groupby=1",
        'select "costing".equipment->\'site\' as "site",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select group by multiple fields', () =>
      expectation(
        "/olap/costing?select='site':equipment->'site','mass':sum(measures->'mass')&groupby=1,2",
        'select "costing".equipment->\'site\' as "site",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1,2',
        handler,
      ));

    it('Select event_date dimension', () =>
      expectation(
        "/olap/costing?select='date':event_date[month],'mass':sum(measures->'mass')&groupby=1",
        'select date_trunc(\'month\', "costing".event_date) as "date",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select event_date dimension, unaliased', () =>
      expectation(
        "/olap/costing?select=event_date[month],'mass':sum(measures->'mass')&groupby=1",
        'select date_trunc(\'month\', "costing".event_date),sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select status dimension', () =>
      expectation(
        "/olap/costing?select='status':status,'mass':sum(measures->'mass')&groupby=1",
        'select "costing".status as "status",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select type dimension', () =>
      expectation(
        "/olap/costing?select='type':type,'mass':sum(measures->'mass')&groupby=1",
        'select "costing".type as "type",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select specific dimension', () =>
      expectation(
        "/olap/costing?select='energy':dimensions->'energy','mass':sum(measures->'mass')&groupby=1",
        'select "costing".dimensions->\'energy\' as "energy",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select dimension with cube', () =>
      expectation(
        "/olap/costing?select='energy':'costing'.dimensions->'energy','mass':sum(measures->'mass')&groupby=1",
        'select "costing".dimensions->\'energy\' as "energy",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select measure', () =>
      expectation(
        "/olap/costing?select='status':status,'tariff':avg(measures->'money'/measures->'mass')&groupby=1",
        'select "costing".status as "status",avg(cast(("costing".measures->\'money\' / "costing".measures->\'mass\') as numeric)) as "tariff" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select measure, aliased', () =>
      expectation(
        "/olap/'c':costing?select='status':status,'tariff':avg(measures->'money'/measures->'mass')&groupby=1",
        'select "c".status as "status",avg(cast(("c".measures->\'money\' / "c".measures->\'mass\') as numeric)) as "tariff" from olap."costing" "c" group by 1',
        handler,
      ));

    it('Select measure with cube', () =>
      expectation(
        "/olap/costing?select='status':status,'tariff':avg('costing'.measures->'money'/measures->'mass')&groupby=1",
        'select "costing".status as "status",avg(cast(("costing".measures->\'money\' / "costing".measures->\'mass\') as numeric)) as "tariff" from olap."costing" "costing" group by 1',
        handler,
      ));

    it('Select event_date filter', () =>
      expectation(
        "/olap/costing?select='status':status,'mass':sum(measures->'mass')&where=event_date>'2016-01-01'&groupby=1",
        'select "costing".status as "status",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" where "costing".event_date > \'2016-01-01\' group by 1',
        handler,
      ));

    it('Select dimension filter', () =>
      expectation(
        "/olap/costing?select='status':status,'mass':sum(measures->'mass')&where=status!='new'&groupby=1",
        'select "costing".status as "status",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" where "costing".status != \'new\' group by 1',
        handler,
      ));

    it('Select measure filter', () =>
      expectation(
        "/olap/costing?select='status':status,'mass':sum(measures->'mass')&where=measures->'mass'>0&groupby=1",
        'select "costing".status as "status",sum(cast(("costing".measures->\'mass\') as numeric)) as "mass" from olap."costing" "costing" where "costing".measures->\'mass\' > (0)::numeric group by 1',
        handler,
      ));

    it('Select asset favorite', () =>
      expectation(
        "/thing/'a':asset?include='t':thing['a'.thing_id='t'.id],'f':security.favorite[and('f'.key='a'.id,'f'.favorite_type_id=1,'f'.user_id=4), left]&select='a'.id,'t'.name,'isFavorite':isnotnull('f'.id)&where='a'.id=1",
        'select "a".id,"t".name,"f".id notnull as "isFavorite" from thing."asset" "a" inner join thing."thing" "t" on ("a".thing_id = "t".id) left join security."favorite" "f" on ("f".key = "a".id and "f".favorite_type_id = (1)::numeric and "f".user_id = (4)::numeric) where "a".id = (1)::numeric',
        handler,
      ));

    it('Select all datasets', () =>
      expectation(
        `/thing/'d':dataset?include='td':thing_dataset['td'.dataset_id='d'.id],'t':thing['t'.id='td'.thing_id],'tp':thing_profile['tp'.thing_id='t'.id],'p':profile[and('p'.id='tp'.profile_id,'d'.profile_id='tp'.profile_id)],'f':security.favorite[and('f'.key='td'.id,'f'.user_id=1,'f'.favorite_type_id=6),left]&where=and((or('d'.user_id=1, isnull('d'.user_id))),'t'.id=2)&select='td'.id,'typeId':6,'type':'dataset','d'.name,'assetId':'t'.id,'d'.description,'isFavorite':isnotnull('f'.id),'profile':'p'.name,'profileId':'p'.id`,
        `select "td".id,6 as "typeId",'dataset' as "type","d".name,"t".id as "assetId","d".description,"f".id notnull as "isFavorite","p".name as "profile","p".id as "profileId" from thing."dataset" "d" inner join thing."thing_dataset" "td" on ("td".dataset_id = "d".id) inner join thing."thing" "t" on ("t".id = "td".thing_id) inner join thing."thing_profile" "tp" on ("tp".thing_id = "t".id) inner join thing."profile" "p" on ("p".id = "tp".profile_id and "d".profile_id = "tp".profile_id) left join security."favorite" "f" on ("f".key = "td".id and "f".user_id = (1)::numeric and "f".favorite_type_id = (6)::numeric) where ("d".user_id = (1)::numeric or "d".user_id isnull) and "t".id = (2)::numeric`,
        handler,
      ));

    it('getAvailablePermissionsByRoleId', () =>
      expectation(
        `/security/permission?include='rt':resource_type[id=resource_type_id]&include='a':application[id='rt'.application_id]&include='r':role[application_id='a'.id]&select=id,'rt'.name,action&where=and('rt'.is_primary=true,'r'.id=1)&orderby=2`,
        `select "permission".id,"rt".name,"permission".action from security."permission" "permission" inner join security."resource_type" "rt" on ("rt".id = "permission".resource_type_id) inner join security."application" "a" on ("a".id = "rt".application_id) inner join security."role" "r" on ("r".application_id = "a".id) where "rt".is_primary = true and "r".id = (1)::numeric order by 2`,
        handler,
      ));

    it('getAvailablePermissionsByRoleId, limit', () =>
      expectation(
        `/security/permission?include='rt':resource_type[id=resource_type_id]&include='a':application[id='rt'.application_id]&include='r':role[application_id='a'.id]&select=id,'rt'.name,action&where=and('rt'.is_primary=true,'r'.id=1)&orderby=2&limit=10`,
        `select "permission".id,"rt".name,"permission".action from security."permission" "permission" inner join security."resource_type" "rt" on ("rt".id = "permission".resource_type_id) inner join security."application" "a" on ("a".id = "rt".application_id) inner join security."role" "r" on ("r".application_id = "a".id) where "rt".is_primary = true and "r".id = (1)::numeric order by 2 limit 10`,
        handler,
      ));
  });

  describe('Delete endpoint', () => {
    const handler = handlers.find((h) => h.endpoint === 'delete') as Handler;

    it('Simple filter', () =>
      expectation(
        "/vero/agent?where=and(status='active',tenant=1)&returning=none",
        'delete from vero."agent" "agent" where "agent".status = \'active\' and "agent".tenant = (1)::numeric',
        handler,
      ));
  });

  describe('Rpc endpoint', () => {
    const handler = handlers.find((h) => h.endpoint === 'rpc') as Handler;

    it('Simple rpc', () =>
      expectation('/rex/get_asset_hierarchy?args=0', 'select * from "rex".get_asset_hierarchy($1)', handler));

    it('Simple rpc no parameter', () =>
      expectation('/rex/get_asset_hierarchy_flat', 'select * from "rex".get_asset_hierarchy_flat()', handler));

    it('Simple rpc array parameter', () =>
      expectation(
        '/rex/get_filtered_asset_hierarchy?args=[1,2,3],4',
        'select * from "rex".get_filtered_asset_hierarchy($1,$2)',
        handler,
      ));

    it('Simple rpc null parameter', () =>
      expectation(
        '/rex/get_filtered_asset_hierarchy?args=null,1',
        'select * from "rex".get_filtered_asset_hierarchy($1,$2)',
        handler,
      ));
  });
});
