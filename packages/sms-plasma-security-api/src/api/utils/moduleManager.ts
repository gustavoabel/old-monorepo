import { spawnSync } from 'child_process';

const moduleExists = (moduleName: string) => {
  try {
    require.resolve(moduleName);
    return true;
  } catch {
    return false;
  }
};

export const installModules = (moduleNames: string[]) => {
  const modules = moduleNames.filter((name) => !moduleExists(name));
  if (modules.length) spawnSync('npm', ['install', ...modules, '--no-save'], { shell: true });
};
