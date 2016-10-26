#install npm modules
npm install --save-dev \
postcss \
postcss-autoreset \
postcss-cli \
postcss-cssnext \
postcss-extend \
postcss-import \
postcss-initial \
postcss-nested \
colorguard \

#crete directories and files
mkdir style
echo 'html{background-color:black;}' > style/index.css

#create scripts
npm run set scripts build-css 'postcss --local-plugins --use postcss-extend --use postcss-import --use postcss-cssnext --use postcss-nested --use colorguard --use postcss-autoreset  --use postcss-initial -o ./dist/index.css ./style/index.css'
