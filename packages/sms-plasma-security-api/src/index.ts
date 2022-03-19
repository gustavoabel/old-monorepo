import { run } from '@sms/plasma-nodejs-api';

run({
  cors: {
    origin: process.env.CORS_ORIGIN_URL?.split(','),
    credentials: true,
    exposedHeaders: 'Authorization',
  },
  i18next: {
    backend: { loadPath: `${__dirname}/api/config/i18n/{{lng}}.json` },
  },
});
