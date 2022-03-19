const AntdDayjsWebpackPlugin = require('antd-dayjs-webpack-plugin');
const WebpackBar = require('webpackbar');

module.exports = {
  babel: {
    plugins: [['babel-plugin-styled-components', { pure: true, displayName: true, fileName: false }]],
    loaderOptions: {
      exclude: /node_modules/,
    },
  },
  webpack: {
    plugins: [new AntdDayjsWebpackPlugin(), new WebpackBar()],
  },
  plugins: [
    {
      plugin: {
        overrideCracoConfig: ({ cracoConfig }) => {
          delete cracoConfig.eslint;
          return cracoConfig;
        },
        overrideWebpackConfig: ({ webpackConfig }) => {
          // Remove ESLintWebpackPlugin
          webpackConfig.plugins = webpackConfig.plugins.filter(
            (plugin) => plugin.constructor.name !== 'ESLintWebpackPlugin',
          );

          // Remove ModuleScopePlugin
          webpackConfig.resolve.plugins = webpackConfig.resolve.plugins.filter(
            (plugin) => plugin.constructor.name !== 'ModuleScopePlugin',
          );

          return webpackConfig;
        },
      },
    },
  ],
};
