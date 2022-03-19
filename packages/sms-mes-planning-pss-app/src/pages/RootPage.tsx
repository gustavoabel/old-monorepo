import React, { useEffect } from 'react';

import { withPage, navigate } from '@sms/plasma-ui';

import app from '../config/app.json';

const RootPage: React.FC = () => {
  useEffect(() => navigate(`/${app.code}/sequences`), []);

  return <div />;
};

export default withPage(RootPage);
