require('./support/env.js');
var moduleAbdd = require(`${process.env.PROJECTRUNPATH}/${process.env.TestDir}/support/abdd.js`);
// modify or add myAbdd attributes as necessary
moduleAbdd.baseUrl = 'chrome://version';
module.exports = moduleAbdd;