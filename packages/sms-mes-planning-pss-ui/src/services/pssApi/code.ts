import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

export interface ApiFunctions {
  getSchedulingRuleModel: ApiFunction<{ materialTypeId: number }, void, string>;
}

const root = '/code';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getSchedulingRuleModel: {
    method: 'GET',
    path: `${root}/schedulingRuleModel?materialTypeId={materialTypeId}`,
  },
};
