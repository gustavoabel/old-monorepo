import { lazy } from 'react';

export const HomePage = lazy(() => import('./HomePage/HomePage'));
export const SequenceFormPage = lazy(() => import('./HomePage/SequenceFormPage'));
export const LoginPage = lazy(() => import('./LoginPage'));
export const PlanningHorizonPage = lazy(() => import('./PlanningHorizonPage/PlanningHorizonPage'));
export const PlanningHorizonFormPage = lazy(() => import('./PlanningHorizonPage/PlanningHorizonFormPage'));
export const MaterialFilterPage = lazy(() => import('./MaterialFilterPage'));
export const MaterialFilterFormPage = lazy(() => import('./MaterialFilterPage/MaterialFilterFormPage'));
export const SchedulingRulePage = lazy(() => import('./SchedulingRulePage/SchedulingRulePage'));
export const SchedulingRuleFormPage = lazy(() => import('./SchedulingRulePage/SchedulingRuleFormPage'));
export const LimitConfigurationPage = lazy(() => import('./LimitConfigurationPage/LimitConfigurationPage'));
