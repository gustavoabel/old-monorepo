const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const PORT = 8080;

const HOST_MAP = {
  admin: '172.28.3.110',
  rex: '172.28.3.117',
  pss: 'localhost',
  plasma: '100.98.0.158',
};

const args = process.argv[2];
const appName = args ? args.replace('--', '') : undefined;
const host = HOST_MAP[appName];

if (!host) {
  const availableArgs = Object.keys(HOST_MAP)
    .map((name) => `--${name}`)
    .join(' or ');

  console.log(`Missing argument: [${availableArgs}]`);
  process.exit(1);
}

const proxyMap = {
  '/api/db': `http://${host}:12080/api`,
  '/api/ts': `http://${host}:12081/api`,
  '/admin/api': `http://${host}:3001/api`,
  '/grafana': `http://${host}:13000`,
  '/api/v1': `http://${host}:5002/api/v1`,
  '/security/api': `http://${host}:3001/api`,
  '/': 'http://localhost:3000',
};

const app = express();

Object.entries(proxyMap).forEach(([source, target]) => {
  app.use(source, createProxyMiddleware({ target, changeOrigin: true, pathRewrite: { [`^${source}`]: '' } }));
});

app.listen(PORT, (port) => {
  console.log(`\nProxy server listening at http://localhost:${PORT}!`);
});
