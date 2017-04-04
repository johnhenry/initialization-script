./node_modules/browserify/bin/cmd.js $1 -t [ babelify \
  --presets [ es2015 react stage-3] ] \
  --plugins [ transform-es2015-destructuring \
              transform-async-generator-functions \
              minify-constant-folding \
              minify-mangle-names \
              transform-runtime]] \
              -v
