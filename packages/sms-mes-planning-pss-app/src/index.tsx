import React, { FunctionComponent } from 'react';
import ReactDOM from 'react-dom';

import { translations as pssTranslations, ModalFormProvider, SequenceMaterialsProvider } from '@sms-mes/pss-ui';
import { translations as auditTranslations } from '@sms/plasma-audit-ui';
import { BaseApp, translations as baseTranslations } from '@sms/plasma-security-ui';
import { defaultThemeDimensions } from '@sms/plasma-ui';
import dayjs from 'dayjs';
import timezone from 'dayjs/plugin/timezone';
import utc from 'dayjs/plugin/utc';

import logo from './assets/img/logo.svg';
import app from './config/app.json';
import appTranslations from './config/i18n';
import menu from './config/menu.json';
import pages from './pages';

import './assets/css/main.scss';

dayjs.extend(utc);
dayjs.extend(timezone);
localStorage.setItem('@sms:theme', JSON.stringify(defaultThemeDimensions));

const mergedTranslations = [appTranslations, pssTranslations, baseTranslations, auditTranslations];

const MainApp: FunctionComponent = () => (
  <ModalFormProvider>
    <SequenceMaterialsProvider>
      <BaseApp
        code={app.code}
        logo={logo}
        translations={mergedTranslations}
        menu={menu}
        pages={pages}
        title={app.title}
      />
    </SequenceMaterialsProvider>
  </ModalFormProvider>
);
ReactDOM.render(<MainApp />, document.getElementById('root'));
