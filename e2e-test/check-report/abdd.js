const path = require('path');
const PROJECTBASE = process.env.PROJECTBASE || 'test-projects';
const PROJECTNAME = process.env.PROJECTNAME || path.resolve().split(PROJECTBASE)[1].split('/')[1];
var moduleDepth = path.resolve(__dirname).split(PROJECTNAME)[1].split('/').length - 2;
var relativePathToProject = '../'.repeat(moduleDepth);
// define module level Env vars here
process.env.TestDir = path.resolve(__dirname).split(PROJECTNAME)[1].split('/')[1];
process.env.TestModule = path.resolve(__dirname).split(PROJECTNAME)[1].split('/')[2];
require(relativePathToProject + 'support/env.js');
require(path.resolve(__dirname) + '/support/env.js');
var moduleAbdd = require(`${process.env.PROJECTRUNPATH}/${process.env.TestDir}/support/abdd.js`);
// modify or add myAbdd attributes as necessary
module.exports = moduleAbdd;
