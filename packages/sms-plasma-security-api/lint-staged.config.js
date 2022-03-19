module.exports = {
  '**/*.{js,css,scss,md}': ['prettier --write'],
  '**/*.{ts,tsx}': ['prettier --write', 'eslint --fix --max-warnings 0'],
};
