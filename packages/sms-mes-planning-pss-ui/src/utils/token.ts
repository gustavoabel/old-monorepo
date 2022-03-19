interface TokenPayload {
  id: number;
  username: string;
  first_name?: string;
  last_name?: string;
  email?: string;
}

export const getTokenData = (): TokenPayload | undefined => {
  const token = localStorage.getItem('@sms-mes/pss:token');

  if (!token) return;

  const userConfig = JSON.parse(window.atob(token)) as TokenPayload;

  return userConfig;
};
