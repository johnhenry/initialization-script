const fs = require("fs");
const ejs = require("ejs");
const path = require("path");
const cwd = process.cwd();
let data;
try{
  data = require(path.join(cwd,"readme", "readme.md.json"));
}catch(e){
  data = {};
}
const template = fs.readFileSync(path.join(cwd, "readme", "readme.md.ejs"), "utf-8");
fs.writeFileSync(path.join(cwd, "readme.md"), ejs.compile(template)(Object.assign(require(path.join(cwd, "package.json")),data)));
