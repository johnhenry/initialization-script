#install npm modules
npm install --save-dev \
ejs \

# crete directories and files
mkdir readme
echo '{"title":"Readme"}' > readme/readme.md.json
echo '# <%= title %>' > readme/readme.md.ejs
mkdir readme/.script
#create script
echo 'const fs = require("fs");
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
fs.writeFileSync(path.join(cwd, "readme.md"), ejs.compile(template)(data));' > readme/.script/generate.js

#create scripts
npm run set scripts generate-readme 'node ./readme/.script/generate'
