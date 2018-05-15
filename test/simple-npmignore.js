

const utils = require('../dist/utils');
const fs = require('fs');

const npmignore = String(fs.readFileSync(__dirname + '/../.npmignore')).trim();
const ignores = utils.npmIgnoreToArray(npmignore);

console.log('ignores:', ignores);

const excludeArray = utils.npmIgnoreToTARExclude(ignores);

console.log('exclusions:', excludeArray);
