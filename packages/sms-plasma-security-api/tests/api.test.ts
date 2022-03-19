/**
 *  Test suite for ADMIN API endpoints. It includes tests of both the HTTP and the UDS servers
 */

import { create, ApiFunction, ApiEndpoints, ApiConfig } from '@sms/plasma-api-client';
import { expect } from 'chai';

interface ApiFunctions {
  postLogin: ApiFunction<void, { username?: string; password?: string }, unknown>; // eslint-disable-line
}

const endpoints: ApiEndpoints<ApiFunctions> = {
  postLogin: '/auth/login',
};

const run = (config: ApiConfig) => {
  const api = create<ApiFunctions>(endpoints, config);

  describe('/auth/login', () => {
    it('Should run without error', async () => {
      const { ok } = await api.postLogin({ data: { username: 'admin', password: 'admin' } });
      expect(ok).to.equal(true);
    });

    it('Should return BadRequest', async () => {
      const { status } = await api.postLogin({ data: { username: 'admin' } });
      expect(status).to.equal(400);
    });

    it('Should return Unauthorized', async () => {
      const { status } = await api.postLogin({ data: { username: 'admin', password: 'wrong' } });
      expect(status).to.equal(401);
    });
  });
};

describe('API Tests', () => {
  describe('HTTP', () => run({ path: 'http://localhost:3001', prefix: 'api' }));
  describe('UDS', () => run({ protocol: 'UDS', path: '/tmp/security-api.sock', prefix: 'api' }));
});
