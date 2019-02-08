const openwhisk = require('openwhisk')
const https = require('https');

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

  //https.get(params.url, (res) => {
    //console.log('statusCode:', res.statusCode);
    //console.log('headers:', res.headers);

    //res.setEncoding('utf8');
    //let rawData = '';
    //res.on('data', (chunk) => { rawData += chunk; });
    //res.on('end', () => {
      //console.log('data:', rawData);
      //ow.actions.create({name, rawData}).then(result => {
        //console.log('action created!', name)
      //}).catch(err => {
        //console.error('failed to create action', err)
      //});
    //});
  //}).on('error', (e) => {
    //console.error(e);
  //});

  return { success: true }
}

//console.log('-----------')
//console.log(main({ name: 'anonymizer', url: 'https://raw.githubusercontent.com/TPei/yappl_transformation_functions/master/functions/anonymizer/anonymizer.js' }))
