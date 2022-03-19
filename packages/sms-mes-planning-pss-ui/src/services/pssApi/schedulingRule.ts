import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { SchedulingRuleTypes } from '../../types';

export interface ApiFunctions {
  getAllSchedulingRule: ApiFunction<void, void, SchedulingRuleTypes.SchedulingRule[]>;
  createSchedulingRule: ApiFunction<void, Omit<SchedulingRuleTypes.SchedulingRule, 'id'>, void>;
  updateSchedulingRule: ApiFunction<void, SchedulingRuleTypes.SchedulingRule, void>;
  deleteSchedulingRule: ApiFunction<{ id: string | number }, void, void>;
}

const root = '/schedulingRule';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllSchedulingRule: {
    method: 'GET',
    path: `${root}`,
  },
  createSchedulingRule: {
    method: 'POST',
    path: `${root}`,
  },
  updateSchedulingRule: {
    method: 'PUT',
    path: `${root}`,
  },
  deleteSchedulingRule: {
    method: 'DELETE',
    path: `${root}/{id}`,
  },
};
