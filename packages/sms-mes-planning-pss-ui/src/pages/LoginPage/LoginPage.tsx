import React from 'react';

import { LoginPage as Login, withPage } from '@sms/plasma-ui';

export interface Props {
  image: string;
}

interface FormData {
  username: string;
  password: string;
}

const handleSubmit = ({ username }: FormData) => {
  const user = {
    id: 1,
    first_name: username,
  };
  const token = btoa(JSON.stringify(user));

  localStorage.setItem('@sms-mes/pss:token', token);

  window.location.href = '/';
};

function LoginPage({ image }: Props) {
  return <Login image={image} onSubmit={handleSubmit} />;
}

export default withPage(LoginPage);
