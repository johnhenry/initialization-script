# Initialization Script

This is a set of initialization scripts that use common tools and shell scripts to help me prototype projects.

It makes use of shell scripts and npm to organize scripts store project data.

The project's capabilities can be extended by running extension scripts (see below).

## Pre-requesties

These commands are designed to work on linux and unix machines, including machines running macOS.

If you're running Windows 10 Professional, you can run them using the [Windows subsystem for Linux](https://msdn.microsoft.com/en-us/commandline/wsl/install_guide?f=255&MSPPError=-2147217396) or within a [Docker container](https://docker.com).

If you're running some other version of Windows, the npm scripts _should_ work, but extension scripts will fail. You might want to try [cygwin](https://www.cygwin.com/) in this case, or try downloading and running the script source manually.

Ensure that these utilities are installed first:

- [sh](https://en.wikipedia.org/wiki/Bourne_shell)
- [node / npm](https://nodejs.org)
- [git](https://git-scm.com/)
- [curl](https://curl.haxx.se)
(curl is only necessary for extension scripts)

## Usage

In your project directory, run the following script:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/init.sh)"
```

This and also adds get, set, and delete npm scripts that allow manipulation of the package as a key-value store.

Once you've run that script, you can run any of below installation scripts to add functionality to your project.

### NPM run Scripts

Running installation scripts will usually add an npm command.

The following commands are installed when adding the above initial script.

#### get: read a value from package.json

```bash
npm run get < path in package.json >
```

#### set: add a key to package.json

```bash
npm run set < path in package.json > 'value to set'
```

#### delete: remove a key from package.json

```bash
npm run delete < path in package.json >
```

### included files

#### .npmrc
	set up with 'save=true' to save installed dependencies automatically

#### .gitignore
	set up to ignore 'node_modules/' folder

## Installation scripts
Update project capabilities by running scripts in the project directory.

### generate-readme.sh
- Compile a readme from json and ejs
- Creates script:
  - npm run generate-readme
- Creates files:
  - readme/readme.md.json
	- readme/readme.md.ejs
  - readme/.script/generate.js

- Compiles to files:
  - readme.md

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/js-next-browser-slug.sh)"
```

### tag-git-npm-version.sh
- Tag repo with package version upon running git version <'major'|'minor'|'patch'>

- Note: must be run after cloning repository or running git init

- Creates scripts:
  - npm run install < package name >
  - npm run uninstall < package name >

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/tag-git-npm-version.sh)"
```

### js-next-browser-slug.sh
- Compile latest version of javascript into a self-contained slug for use in the browser
- Creates script:
  - npm run build-js-browser
- Creates files:
  - script/index.js
- Compiles to files:
  - dist/index.js

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/js-next-browser-slug.sh)"
```

### node-next.sh
- Run a node script written in the latest version of javascript
- Creates script:
  - npm run node
- Creates files:
  - node/index.js

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/node-next.sh)"
```

### css-next-slug.sh
- Compile latest version of css into a self-contained slug
- Creates script:
  - npm run build-css
- Creates files:
  - style/index.css
- Compiles to files:
  - dist/index.css

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/css-next-slug.sh)"
```

### html.sh
- Compile react components into static html files.
- Creates script:
  - npm run build-html
- Creates files:
  - html/.md.jsx.html.js
  - html/index.jsx
- Compiles to files:
  - dist/index.js

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/html.sh)"
```

### serve-static.sh
- Run static server
- Creates script:
  - npm run serve-static
- Requires files:
  - dist/

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/serve-static.sh)"
```

## unfinished installation scripts

These scripts will be ready soon.

### js-next-slug.sh
- Compile latest version of javascript into a self-contained slug
- Creates script:
  - npm run build-js
- Creates files:
  - script/index.js
- Compiles to files:
  - dist/index.js

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/js-next-slug.sh)"
```

### lint-js.sh
- Lint JavaScript
- Creates scripts:
  - npm run lint-js < package name >

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/lint-js.sh)"
```

### lint-css.sh
- Lint CSS
- Creates scripts:
  - npm run lint-css < package name >

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/lint-css.sh)"
```

### move.sh
- Move static files into dist directory
- Creates script:
  - npm run move
- Requires files:
  - static/*
  - dist/

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/move.sh)"
```

### deploy-surge.sh
- Push static site to https://surge.sh
- Creates script:
  - npm run deploy-surge
- Requires files:
  - dist/*

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/johnhenry/startled/master/.scripts/deploy-surge.sh)"
```
