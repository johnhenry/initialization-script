#install npm modules
npm install --save-dev \
babel-cli \
babel-polyfill \
babel-plugin-transform-es2015-destructuring \
babel-preset-stage-3 \
babel-preset-latest \
babel-preset-react \

#crete directories and files
mkdir node
echo 'console.log("hi");' >> node/index.js

#create scripts
npm run set scripts node 'babel-node --debug --presets latest,react,stage-3 --plugins transform-es2015-destructuring node/index.js'
