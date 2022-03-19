const pkg = require('./package.json');

const rewrite = pkg.homepage ? [{ from: `/${pkg.homepage}/(.*).(.*)`, to: '/$1.$2' }] : undefined;

module.exports = {
  port: 3000,
  directory: 'build',
  spa: 'index.html',
  staticMaxage: 31536000,
  compress: true,
  rewrite,
};
