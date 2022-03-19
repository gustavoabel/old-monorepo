const { spawnSync } = require('child_process');
const commander = require('commander');
const flywayRun = (args) => {
  const spawnOptions = { stdio: 'inherit', shell: true };
  const command = process.platform === 'win32' ? 'flyway.cmd' : 'flyway';
  spawnSync(command, args, spawnOptions);
};
const tryResolve = (dependency) => {
  try {
   return require.resolve(`${dependency}/package.json`);
  } catch {
    /* IGNORE */
  }
};
const main = () => {
  const [, , command, ...depArgs] = process.argv;
  const dependencies = depArgs.filter(el => !el.startsWith('--'));
  commander
    .option('--ver <version>', 'To input a version')
    .option('--sample <sampleFolder>', 'To input a sample folder')
    .parse(process.argv);
  const version = commander.ver;
  let commands = [];
  switch (command)  {
    case 'clean':
      commands.push([`-schemas=${depArgs}`,'clean']);
      break;
    case 'migrate':
    case 'migrate-sample':
      if (!version) {
        console.error('migrate requires version: -- --ver=1');
        return;
      }
      if( command == 'migrate-sample' && commander.sample.length == 0){
        console.error('migrate-sample requires sample: --sample=folder');
        return;
      }
      const depCommands = dependencies
      .map((dependency) => {
        const dependenciesToResolve = [
        `@digital/${dependency}-db`,
        `@sms/${dependency}-db`,
        `@sms/plasma-${dependency}-db`,
      ];
      const depPath =
      tryResolve(dependenciesToResolve[0]) ||
      tryResolve(dependenciesToResolve[1]) ||
      tryResolve(dependenciesToResolve[2]);
      if (depPath) {
          const json = require(depPath);
          const commandPath = depPath.replace(/\\/g, "/").replace('/package.json', '');
          const truncatedVersion = json.version.split('.').slice(0,2).join('.');
          return [`-locations=filesystem:${commandPath}/V*/migrate${
            (
              command == 'migrate-sample' ? `,filesystem:${commandPath}/V*/sample/${commander.sample}`
              : ''
            )} -schemas=${dependency} -target="${truncatedVersion}"`, "migrate"];
        } else {
          throw new Error(`Could not resolve dependency: ${dependenciesToResolve.map((d) => `"${d}"`).join(' or ')}`);
        }
      });
      commands.push(...depCommands);
      if (version){
        commands.push([`-locations=filesystem:./V*/migrate${
          (
            command == 'migrate-sample' ? `,filesystem:./V*/sample/${commander.sample}`
            : ''
          )} -schemas=pss -target=${version}`, "migrate"]);
      }
      break;
  }
  commands.forEach(flywayRun);
};
main();
