const openwhisk = require('openwhisk')

function main(params) {
  const ow = openwhisk();

  let name = params.package.name;

  return ow.packages.create({
    "name": name,
    "result": true,
    "blocking": true
  });
}
