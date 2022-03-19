import { ApiEndpoints, ApiFunction } from '@sms/plasma-api-client';
import { PlanningHorizonTypes } from '../../types';

export interface ApiFunctions {
  getAllPlanningHorizon: ApiFunction<void, void, PlanningHorizonTypes.PlanningHorizon[]>;
  getComboPlanningHorizon: ApiFunction<
    { id: number },
    void,
    Omit<
      PlanningHorizonTypes.PlanningHorizon,
      'description' | 'horizon' | 'isDefault' | 'productionUnitGroupId' | 'materialAttributeDefinitionId'
    >[]
  >;
  createPlanningHorizon: ApiFunction<void, Omit<PlanningHorizonTypes.PlanningHorizon, 'id'>, void>;
  updatePlanningHorizon: ApiFunction<void, PlanningHorizonTypes.PlanningHorizon, void>;
  deletePlanningHorizon: ApiFunction<{ id: string | number }, void, void>;
}

const root = '/planningHorizon';

export const endpoints: ApiEndpoints<ApiFunctions> = {
  getAllPlanningHorizon: {
    method: 'GET',
    path: `${root}`,
  },
  getComboPlanningHorizon: {
    method: 'GET',
    path: `${root}/{id}`,
  },
  createPlanningHorizon: {
    method: 'POST',
    path: `${root}`,
  },
  updatePlanningHorizon: {
    method: 'PUT',
    path: `${root}`,
  },
  deletePlanningHorizon: {
    method: 'DELETE',
    path: `${root}/{id}`,
  },
};
