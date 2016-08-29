var fs = require('fs');
var ejs = require('ejs');
var path = require('path');
var encoding = 'utf-8'
var project = './../PROJECT/';
var cwd = process.cwd();
var data = require(path.join(cwd, project, 'readme-src', 'data.json'));
var template = fs.readFileSync(path.join(cwd, project, 'readme-src', 'readme.md'), encoding);
var compiled = ejs.compile(template)(data)
fs.writeFileSync(path.join(cwd, project, 'readme.md'), compiled);
