import React from 'react';

import {
  HomePage,
  MaterialFilterPage,
  PlanningHorizonPage,
  PlanningHorizonFormPage,
  MaterialFilterFormPage,
  SchedulingRulePage,
  SchedulingRuleFormPage,
  SequenceFormPage,
  LimitConfigurationPage,
} from '@sms-mes/pss-ui';
import { AuditTrailPage } from '@sms/plasma-audit-ui';
import {
  LoginPage,
  RolePage,
  RoleCreatePage,
  UserPage,
  InviteUserPage,
  IdentityProviderEditPage,
  IdentityProviderCreatePage,
  IdentityProviderPage,
  ApplicationParameterPage,
  ApplicationCreatePage,
  ApplicationEditPage,
  RegisterPage,
  WelcomePage,
} from '@sms/plasma-security-ui';
import { PageConfig, UnderConstructionPage } from '@sms/plasma-ui';

import backgroundImage from '../assets/img/background.jpg';
import app from '../config/app.json';

const RootPage = React.lazy(() => import('./RootPage'));

const pages: PageConfig[] = [
  {
    key: 'Root',
    path: '/',
    page: RootPage,
  },
  {
    key: 'Login',
    path: '/login',
    page: LoginPage,
    unprotected: true,
    params: {
      image: backgroundImage,
      title: 'app.commons.auth.title',
      subtitle: 'app.commons.auth.subtitle',
    },
  },
  {
    key: 'Register',
    path: '/register',
    page: RegisterPage,
    unprotected: true,
    params: {
      app: app.title,
      image: backgroundImage,
      title: 'app.commons.auth.title',
      subtitle: 'app.commons.auth.subtitle',
      signInRoutePath: '/login',
      privacyPolicyTitle: 'app.page.register.privacyPolicy.title',
      privacyPolicyRoutePath: process.env.REACT_APP_PORTAL_PRIVACY_POLICY_URL,
    },
  },
  {
    key: 'Welcome',
    path: '/verify',
    page: WelcomePage,
    unprotected: true,
    params: {
      app: app.title,
      image: backgroundImage,
      title: 'app.commons.auth.title',
      subtitle: 'app.commons.auth.subtitle',
      signInRoutePath: '/login',
    },
  },
  {
    key: 'SequencePage',
    path: '/pss/sequences',
    title: 'app.page.home',
    page: HomePage,
  },
  {
    key: 'HomePage',
    path: '/pss',
    title: 'app.page.home',
    page: RootPage,
  },
  {
    key: 'SequencePageCreate',
    path: '/pss/sequences/create',
    title: 'app.page.home',
    page: SequenceFormPage,
  },
  {
    key: 'AuditTrail',
    path: '/pss/system/auditTrail',
    page: AuditTrailPage,
    title: 'app.page.system.auditTrail',
    help: '/auditTrail/index.html',
    permissions: [['log:READ']],
  },
  {
    key: 'UsageStatistics',
    path: '/pss/system/usageStatistics',
    page: UnderConstructionPage,
    title: 'app.page.system.usageStatistics',
  },
  {
    key: 'ApplicationParameter',
    path: '/pss/system/applicationParameter',
    page: ApplicationParameterPage,
    title: 'app.page.system.parameters',
    help: '/system/applicationParameter/index.html',
    permissions: [['application:READ', 'application:WRITE']],
  },
  {
    key: 'ApplicationCreate',
    path: '/pss/system/applications/create',
    page: ApplicationCreatePage,
    title: 'app.page.system.applications',
    permissions: [['application:WRITE']],
  },
  {
    key: 'ApplicationEdit',
    path: '/pss/system/applications/:id',
    page: ApplicationEditPage,
    title: 'app.page.system.applications',
    permissions: [['application:READ', 'application:WRITE']],
  },
  {
    key: 'MaterialFilter',
    title: 'app.page.materialFilter',
    path: '/pss/materialFilter',
    page: MaterialFilterPage,
  },
  {
    key: 'MaterialFilterCreate',
    title: 'app.page.materialFilter',
    path: '/pss/materialFilter/create',
    page: MaterialFilterFormPage,
  },
  {
    key: 'PlanningHorizon',
    title: 'app.page.planningHorizon',
    path: '/pss/planningHorizon',
    page: PlanningHorizonPage,
  },
  {
    key: 'PlanningHorizonCreate',
    title: 'app.page.planningHorizon',
    path: '/pss/planningHorizon/create',
    page: PlanningHorizonFormPage,
  },
  {
    key: 'SchedulingRule',
    title: 'app.page.schedulingRule',
    path: '/pss/schedulingRule',
    page: SchedulingRulePage,
  },
  {
    key: 'SchedulingRuleCreate',
    title: 'app.page.schedulingRule',
    path: '/pss/schedulingRule/create',
    page: SchedulingRuleFormPage,
  },
  {
    key: 'LimitConfiguration',
    title: 'app.page.limitConfiguration',
    path: '/pss/limitConfiguration',
    page: LimitConfigurationPage,
  },
  {
    key: 'IdentityProvider',
    path: '/pss/security/identityProviders',
    page: IdentityProviderPage,
    title: 'app.page.security.identityProviders',
    help: '/security/identityProviders/index.html',
    permissions: [['identity_provider:READ', 'identity_provider:WRITE']],
  },
  {
    key: 'IdentityProviderCreate',
    path: '/pss/security/identityProviders/create',
    page: IdentityProviderCreatePage,
    title: 'app.page.security.identityProviders',
    help: '/security/identityProviders/create/index.html',
    permissions: [['identity_provider:WRITE']],
  },
  {
    key: 'IdentityProviderEdit',
    path: '/pss/security/identityProviders/:id',
    page: IdentityProviderEditPage,
    title: 'app.page.security.identityProviders',
    help: '/security/identityProviders/edit/index.html',
    permissions: [['identity_provider:READ', 'identity_provider:WRITE']],
  },
  {
    key: 'Role',
    path: '/pss/security/roles',
    page: RolePage,
    title: 'app.page.security.roles',
    help: '/roles/index.html',
    permissions: [['role:READ', 'role:WRITE']],
  },
  {
    key: 'RoleCreate',
    path: '/pss/security/roles/create',
    page: RoleCreatePage,
    title: 'app.page.security.roles',
    help: '/roles/create/index.html',
    permissions: [['role:WRITE']],
  },
  {
    key: 'User',
    path: '/pss/security/users',
    page: UserPage,
    title: 'app.page.security.users',
    help: '/users/index.html',
    permissions: [['user:READ', 'user:WRITE']],
  },
  {
    key: 'InviteUser',
    path: '/pss/security/users/invite',
    page: InviteUserPage,
    title: 'app.page.security.users',
    help: '/users/invite/index.html',
    permissions: [['user:WRITE']],
  },
];

export default pages;
