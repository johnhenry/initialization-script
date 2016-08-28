#populate varaibles
github=$GITHUBUSER
gitlab=$GITLABUSER
description=''
randid=$(date +%N)

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

#populate more variables
name=$(tempget name)
description=$(tempget description)
#image names
scripts="scripts"
lint="lint"
compile="compile"
demo="demo"
test="test"
deploy="deploy"
imagenames="$lint $compile $demo $test $deploy"


echo "adding docker scripts to packages.json"
#build image script
tempset scripts "build-images" "docker build -t $name-$lint-$randid $scripts/$lint && docker build -t $name-$compile-$randid $scripts/$compile && docker build -t $name-$demo-$randid $scripts/$demo && docker build -t $name-$test-$randid $scripts/$test && docker build -t $name-$deploy-$randid $scripts/$deploy"
#remove image scripts
tempset scripts "remove-images" "docker rmi \$(docker images -aq $name-*-$randid)"

#add lint script
tempset scripts lint "docker run -v \$(pwd):/PROJECT --rm $name-$lint-$randid"
tempset scripts lint-win "docker run -v %cd%:/PROJECT --rm $name-$lint-$randid"
#add compile script
tempset scripts compile "docker run -v \$(pwd):/PROJECT --rm $name-$compile-$randid"
tempset scripts compile-win "docker run -v %cd%:/PROJECT --rm $name-$compile-$randid"
#add demo script
tempset scripts demo "docker run -v \$(pwd):/PROJECT --rm $name-$demo-$randid"
tempset scripts demo-win "docker run -v %cd%:/PROJECT --rm $name-$demo-$randid"
#add test scripts
tempset scripts test "docker run -v \$(pwd):/PROJECT --rm $name-$test-$randid"
tempset scripts test-win "docker run -v %cd%:/PROJECT --rm $name-$test-$randid"
#add deploy scripts
tempset scripts deploy "docker run -v \$(pwd):/PROJECT --rm $name-$deploy-$randid"
tempset scripts deploy-win "docker run -v %cd%:/PROJECT --rm $name-$deploy-$randid"

#check .npmrc
if [ ! -f .npmrc ]; then
	echo "creating .npmrc"
	echo "save=true;" > .npmrc
fi

####
##git
####
#check existance of git repository
if [ ! -f .git ]; then
	echo "initializing git repository"
	git init -q
fi

#add git repos
git remote add github git@github.com:$github/$name.git
git remote add gitlab git@gitlab.com:$gitlab/$name.git
git remote add origin git@gitlab.com:$gitlab/$name.git

#check .gitignore
if [ ! -f .gitignore ]; then
	gitignore="
node_modules/\n
.DS_Store\n
npm-debug.log\n"
	echo $gitignore >> .gitignore
fi

#check post-commit hook
if [ ! -f ./.git/hooks/post-commit.sh ]; then
	echo "creating post-commit.sh"
	hook="#! /bin/bash\n
	version=\`git diff HEAD^..HEAD -- \"\$(git rev-parse --show-toplevel)\"/package.json | grep '^\+.*version' | sed -s 's/[^0-9\.]//g'\`\n
	\n
	if [ \"\$version\" != \"\" ]; then\n
	    git tag -a \"v\$version\" -m \"\`git log -1 --format=%s\`\"\n
	    echo \"Created a new tag, v\$version\"\n
	fi"
	echo $hook > ./.git/hooks/post-commit.sh
fi

#check existance of readme.md
if [ ! -f ./readme.md ]; then
	echo "creating readme.md"
	readme="# $named\n
## $description\n"
	echo $readme >> readme.md
fi
mkdir $scripts
cd $scripts
#create image files
for imagename in $imagenames
do
	mkdir $imagename
	cd $imagename
	npm init --force
	echo "#! /bin/sh
echo \"$imagename\"
ls src
" >> run
	echo "FROM mhart/alpine-node
COPY run .
RUN chmod +x run
COPY package.json .
RUN npm install" >> Dockerfile
	echo "CMD ./run" >> Dockerfile
	cd ..
done
cd ..
