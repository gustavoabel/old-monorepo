import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { SchedulingRuleTypes } from '../../types';

export interface ApiFunctions {
  getComboSchedulingRuleViolation: ApiFunction<
    void,
    { materialId: number; sequenceItemId: number },
    SchedulingRuleTypes.SchedulingRule[]
  >;
  acceptViolation: ApiFunction<void, { schedulingRuleViolationId: string | number; responsible: string }, void>;
}

const root = '/schedulingRule/violation';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getComboSchedulingRuleViolation: {
    method: 'GET',
    path: `${root}/combo`,
  },
  acceptViolation: {
    method: 'POST',
    path: `${root}/accept`,
  },
};
