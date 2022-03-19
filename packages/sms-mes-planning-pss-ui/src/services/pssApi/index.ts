import { create, ApiConfig } from '@sms/plasma-api-client';
import { Notification, LoadingIndicator, ModalDeleteError, getErrorMessage } from '@sms/plasma-ui';

import * as code from './code';
import * as groupSequence from './groupSequence';
import * as kpi from './kpi';
import * as limitConfiguration from './limitConfiguration';
import * as material from './material';
import * as materialAttribute from './materialAttribute';
import * as materialFilter from './materialFilter';
import * as materialType from './materialType';
import * as planningHorizon from './planningHorizon';
import * as productionUnit from './productionUnit';
import * as productionUnitGroup from './productionUnitGroup';
import * as schedulingRule from './schedulingRule';
import * as schedulingRuleViolation from './schedulingRuleViolation';
import * as sequenceScenario from './sequenceScenario';
import * as unitSequence from './unitSequence';

const endpoints = {
  ...planningHorizon.endpoints,
  ...productionUnitGroup.endpoints,
  ...productionUnit.endpoints,
  ...materialAttribute.endpoints,
  ...material.endpoints,
  ...materialFilter.endpoints,
  ...schedulingRule.endpoints,
  ...schedulingRuleViolation.endpoints,
  ...groupSequence.endpoints,
  ...sequenceScenario.endpoints,
  ...unitSequence.endpoints,
  ...kpi.endpoints,
  ...materialType.endpoints,
  ...code.endpoints,
  ...limitConfiguration.endpoints,
};

interface ApiFunctions
  extends planningHorizon.ApiFunctions,
    productionUnitGroup.ApiFunctions,
    productionUnit.ApiFunctions,
    materialFilter.ApiFunctions,
    material.ApiFunctions,
    groupSequence.ApiFunctions,
    sequenceScenario.ApiFunctions,
    unitSequence.ApiFunctions,
    kpi.ApiFunctions,
    materialAttribute.ApiFunctions,
    materialType.ApiFunctions,
    materialAttribute.ApiFunctions,
    schedulingRule.ApiFunctions,
    schedulingRuleViolation.ApiFunctions,
    groupSequence.ApiFunctions,
    code.ApiFunctions,
    materialFilter.ApiFunctions,
    limitConfiguration.ApiFunctions {}

const config: ApiConfig = {
  path: process.env.REACT_APP_PSS_API_BASE_URL,
  auth: () => `Bearer ${localStorage.getItem('@sms:token')}`,
  routerRedirect: {
    beforeUnauthorizedRedirect: () => localStorage.removeItem('@sms:token'),
    unauthorizedRedirectPath: '/login',
    successRedirectPathDefault: '/pss',
  },
  requestTransform: (req) => {
    LoadingIndicator.show();
    if (window.location.pathname !== '/') {
      // add "application_code" to all requests except launchpad
      const applicationCode = localStorage.getItem('@sms:application_code');
      if (applicationCode) req.headers.application_code = applicationCode;

      const language = localStorage.getItem('@sms:language');
      if (language) req.headers['Accept-Language'] = language.replace('_', '-');
    }
  },
  responseTransform: (res) => {
    LoadingIndicator.hide();

    if (res.status === 401) Notification.warning('base.api.session.expired.message');
    else if (!res.ok) {
      if (res.data?.message) {
        const errorMessage = getErrorMessage(res.data.message);
        if (errorMessage.isCustom) {
          ModalDeleteError(res.data.message);
        } else {
          Notification.warning(errorMessage.message);
        }
      } else {
        Notification.error('base.api.generic.error.message', res);
      }
    }
  },
};

export default create<ApiFunctions>(endpoints, config);
