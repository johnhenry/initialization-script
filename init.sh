####
##npm / package.json
####
#check existance of package.json
if [ ! -f ./package.json ]; then
	echo "creating package.json"
	npm init -f
fi
#temporary set
tempset_="node -e \"var target = './package.json';
var pkg = require(target);
var value = process.argv[process.argv.length - 1];
var p = pkg;
for(var n = 1; n < process.argv.length;n++){
    var key = process.argv[n];
      if(n >= process.argv.length - 2){
          p[key] = value;
          break;
        }else{
          p[key] = p[key] || {};
          p = p[key];
        }
      };
require('fs').writeFileSync(target, (JSON.stringify(pkg, null, '  ')));\""
#temporary get
tempget_="node -e \"var pkg = require('./package.json');
var p = pkg;
var result;
var keys = [];
for(var n = 1; n<process.argv.length;n++){  key = process.argv[n];
  try{
    result = p[key];
    p = pkg[key];
    keys.push(key);
  }catch(e){
    console.error('key: ' + keys.join(' -> ') + ' is not an object' );
    process.exit(1);
  }
}
console.log(result);\""

#temporary delete
tempdelete_="node -e \"var target = './package.json';
var pkg = require(target);
var result;
var p = pkg;
for(var n = 1; n < process.argv.length;n++){
      var key = process.argv[n];
      if(n >= process.argv.length - 1){
          result = p[key];
					delete p[key];
          break;
        }else{
          p[key] = p[key] || {};
          p = p[key];
        }
      };
require('fs').writeFileSync(target, (JSON.stringify(pkg, null, '  ')));
console.log(result);\""

#set temporary functions
alias tempset="$tempset_"
alias tempget="$tempget_"

#add set, get, delete
echo "adding 'get', 'set', and 'delete' scripts to package.json"
tempset scripts set "$tempset_"
tempset scripts get "$tempget_"
tempset scripts delete "$tempdelete_"

#check existance of .npmrc
if [ ! -f .npmrc ]; then
	echo "creating .npmrc"
	echo "save=true" > .npmrc
fi

#check existance of .gitignore
if [ ! -f .gitignore ]; then
	gitignore="node_modules/\n
.DS_Store\n
npm-debug.log\n"
	echo $gitignore >> .gitignore
fi
