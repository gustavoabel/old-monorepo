import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';

import { KPIView } from '../../types/KPI';

export interface ApiFunctions {
  getKPIList: ApiFunction<void, { sequenceScenarioId: string | number }, KPIView[]>;
}

const root = '/kpi';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getKPIList: {
    method: 'GET',
    path: `${root}`,
  },
};
