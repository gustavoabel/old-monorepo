const { getPackages } = require('@lerna/project');
const graphviz = require('graphviz');

const IGNORED_PACKAGES = ['@sms/plasma-api-client'];

async function main() {
  let packages = await getPackages();
  packages = packages.filter((pkg) => !IGNORED_PACKAGES.includes(pkg.name));

  const g = graphviz.digraph('G');
  g.use = 'dot';

  packages.forEach((pkg) => {
    const node = g.addNode(pkg.name);

    if (pkg.private) node.set('style', 'dashed');

    const dependencies = { ...pkg.dependencies, ...pkg.devDependencies, ...pkg.peerDependencies };
    const dependencyKeys = Object.keys(dependencies).filter((depName) => packages.some((p) => p.name === depName));

    dependencyKeys.forEach((depName) => {
      const edge = g.addEdge(node, depName);
      if (pkg.devDependencies[depName]) edge.set('style', 'dashed');
      else if (pkg.devDependencies[depName]) edge.set('style', 'dotted');
    });
  });

  g.output('svg', 'graph.svg');
}

main();
