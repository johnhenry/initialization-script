const fs = require("fs");
const ejs = require("ejs");
const path = require("path");
const yargs = require("yargs");
const cwd = process.cwd();
const app = async ({indir}) => {
  let data;
  try{
    data = require(path.join(cwd, indir, "readme.md.json"));
  }catch(e){
    data = {};
  }
  const template = fs.readFileSync(path.join(cwd, indir, "readme.md.ejs"), "utf-8");
  return ejs.compile(template)(Object.assign(require(path.join(cwd, "package.json") || {}),data));
}
app(yargs.argv).then(console.log.bind(console)).catch(console.error.bind(console));
