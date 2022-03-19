import { run } from '@sms/plasma-nodejs-api';

import handlers from './handlers';

const {
  PARSER_CACHE_SIZE,
  TRANSACTION_CACHE_TTL,
  TRANSACTION_CACHE_CHECK_PERIOD,
  DB_HOST,
  DB_PORT,
  DB_DATABASE,
  DB_USER,
  DB_PASSWORD,
  BODY_PARSER_LIMIT,
} = process.env;

run({
  db: {
    host: DB_HOST,
    port: Number(DB_PORT),
    database: DB_DATABASE,
    user: DB_USER,
    password: DB_PASSWORD,
  },
  parser: {
    handlers,
    cacheSize: Number(PARSER_CACHE_SIZE),
    transactionCacheTTL: Number(TRANSACTION_CACHE_TTL),
    transactionCheckPeriod: Number(TRANSACTION_CACHE_CHECK_PERIOD),
  },
  bodyParser: {
    limit: BODY_PARSER_LIMIT,
  },
  cors: {
    origin: process.env.CORS_ORIGIN_URL?.split(','),
    credentials: true,
    exposedHeaders: 'Authorization',
  },
});
