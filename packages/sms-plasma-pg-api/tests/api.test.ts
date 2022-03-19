/**
 * Test suite for DB API endpoints
 * It includes tests of HTTP server
 */

require('dotenv').config();

import { create, ApiFunction, ApiEndpoints, ApiConfig } from '@sms/plasma-api-client';
import { initializeDb, getDbConnection } from '@sms/plasma-nodejs-api';
import { expect } from 'chai';

interface ApiFunctions {
  postInsertOrders: ApiFunction<unknown, unknown, unknown>;
  postInsertItems: ApiFunction<unknown, unknown, unknown>;
  deleteOrders: ApiFunction<unknown, unknown, unknown>;
  deleteItems: ApiFunction<unknown, unknown, unknown>;
  getAllOrders: ApiFunction<unknown, unknown, unknown[]>;
  getAllOrdersCsv: ApiFunction<unknown, unknown, unknown>;
  getAllVallourecOrders: ApiFunction<unknown, unknown, unknown[]>;
  patchVallourecOrders: ApiFunction<unknown, unknown, unknown>;
}

const endpoints: ApiEndpoints<ApiFunctions> = {
  postInsertOrders: '/insert/public/test_orders?returning=rows(id)',
  postInsertItems: '/insert/public/test_items?returning=rows(id)',
  deleteOrders: '/delete/public/test_orders?where=true',
  deleteItems: '/delete/public/test_items?where=true',
  getAllOrders: '/query/public/test_orders?select=id,customer',
  getAllOrdersCsv: '/query/public/test_orders?select=id,customer&format=csv',
  getAllVallourecOrders:
    "/query/public/'i':test_items?include='o':test_orders[id=order_id]&select='o'.customer,'o'.created_at,'i'.product,'i'.quantity&where='o'.customer='Vallourec'",
  patchVallourecOrders: "/update/public/test_orders?where=customer='Vallourec'",
};

// Data to be inserted into test_orders table
const orders = [
  { customer: 'Vallourec', created_at: '2019-01-01', value: 1000.0 },
  { customer: 'Vallourec', created_at: '2019-01-04', value: 887.0 },
  { customer: 'Usiminas', created_at: '2019-01-03', value: 1228.4 },
];

// Data to be inserted into test_items table
const items = [
  { order_id: 1, product: 'PR01', quantity: 10 },
  { order_id: 1, product: 'PR02', quantity: 20 },
  { order_id: 2, product: 'PR01', quantity: 3 },
  { order_id: 2, product: 'PR03', quantity: 11 },
  { order_id: 2, product: 'PR04', quantity: 8 },
  { order_id: 3, product: 'PR03', quantity: 1 },
];

// Data to be updated in test_orders table
const changes = [{ created_at: '2020-01-01', value: 100.0 }];

const run = (config: ApiConfig) => {
  const api = create<ApiFunctions>(endpoints, config);

  const { DB_HOST, DB_PORT, DB_DATABASE, DB_USER, DB_PASSWORD } = process.env;

  const dbConfig = {
    host: DB_HOST,
    port: Number(DB_PORT),
    database: DB_DATABASE,
    user: DB_USER,
    password: DB_PASSWORD,
  };

  initializeDb(dbConfig);

  /**
   * Before running any test case, start the Api and create temporary tables
   */
  before(async () => {
    const client = await getDbConnection();
    await client.query(
      'create table if not exists test_orders(id serial primary key, customer varchar not null, created_at timestamp, value double precision not null)',
    );
    await client.query(
      'create table if not exists test_items(id serial primary key, order_id integer references test_orders(id) not null, product varchar not null, quantity integer not null)',
    );
  });

  /**
   * After running all test cases, remove temporary tables
   */
  after(async () => {
    const client = await getDbConnection();
    await client.query('drop table if exists test_items');
    await client.query('drop table if exists test_orders');
  });

  /**
   * Suite of adhoc (business oriented) test cases, specially related with query variations
   */
  describe('Adhoc Tests', () => {
    it('Should insert orders without error', async () => {
      const { ok, originalError } = await api.postInsertOrders({ data: orders });
      console.log(originalError);
      expect(ok).to.equal(true);
    });

    // it('Should insert items without error', async () => {
    //   const { ok } = await api.postInsertItems({ data: items });
    //   expect(ok).to.equal(true);
    // });

    // it('Should get all orders without error', async () => {
    //   const { ok } = await api.getAllOrders();
    //   expect(ok).to.equal(true);
    // });

    // it('Should get all orders in CSV format', async () => {
    //   const { ok, headers } = await api.getAllOrdersCsv();
    //   expect(ok).to.equal(true);
    //   if (headers) {
    //     const contentType = (headers as any)['content-type']; // eslint-disable-line
    //     expect(contentType).to.equal('text/plain');
    //   }
    // });

    // it('Should get all Vallourec orders items correctly', async () => {
    //   const { ok, data } = await api.getAllVallourecOrders();
    //   expect(ok).to.equal(true);
    //   if (data) expect(data.length).to.equal(5);
    // });

    // it('Should update Vallourec orders correctly', async () => {
    //   const { ok, data } = await api.patchVallourecOrders({ data: changes });
    //   expect(ok).to.equal(true);
    //   if (data) expect((data as any[]).map((d) => d.id)).to.deep.equal([1, 2]); // eslint-disable-line
    // });

    // it('Should delete items without error', async () => {
    //   const { ok } = await api.deleteItems();
    //   expect(ok).to.equal(true);
    // });

    // it('Should delete orders without error', async () => {
    //   const { ok } = await api.deleteOrders();
    //   expect(ok).to.equal(true);
    // });
  });
};

describe('API Tests', () => {
  describe('HTTP', () => run({ path: 'http://localhost:12080', prefix: 'api' }));
  describe('UDS', () => run({ protocol: 'UDS', path: '/tmp/pg-api.sock', prefix: 'api' }));
});
