const openwhisk = require('openwhisk')

function main(params) {
  const ow = openwhisk();

  let name = params.package + "/" + params.name
  let code = params.code
  let runtime = params.runtime

  return ow.actions.create({
    "name": name,
    "action": code,
    "kind": runtime,
    "result": true,
    "blocking": true
  });
}
