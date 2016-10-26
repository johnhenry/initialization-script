#install npm modules
npm install --save-dev \
browserify \
babelify \
babel-polyfill \
babel-preset-babili \
babel-preset-stage-3 \
babel-preset-latest \
babel-preset-react \
babel-plugin-transform-es2015-destructuring \
babel-plugin-minify-mangle-names \
babel-plugin-minify-constant-folding \

#crete directories and files
mkdir script
echo 'console.log("hi");' > script/index.js

#create scripts
npm run set scripts build-js-browser 'browserify ./script/index.js -d -o ./dist/index.js -t [ babelify --presets [ latest react stage-3 babili] --plugins [ transform-es2015-destructuring minify-constant-folding minify-mangle-names ] ] -v'
