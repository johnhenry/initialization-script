# Initialization Script

##FAQ

### What is this?
This is an initialization script meant to help me, [John Henry](iamjohnhenry.com), organize my projects.

This script combines common tools and shell scripts to create a portable, flexible.

### What do I need to use it.
Here are some pre-requesites that you'll need installed:
- [curl](https://curl.haxx.se)
- [git](https://git-scm.com/)
- [node/npm](https://nodejs.org)
- [docker](https://www.docker.com/products/overview#/install_the_platform)

### How do I use it?

Navigate to a project directory, and run the following command (replacing names as appropriate)

```
GITHUBUSER="<%-githubuser%>" GITLABUSER="<%-gitlabuser%>" sh -c "$(curl -fsSL <%-installation_url%>)"
```

Or, if you prefer to use wget,

```
GITHUBUSER="<%-githubuser%>" GITLABUSER="<%-gitlabuser%>" sh -c "$(wget <%-installation_url%> -O - )"
```


The script works on \*nix machines, so if you are running Windows 10 Professional, you can take advantage of with Windows sub-system for linux to run it.

### What does that do?

#### package.json
This creates a package.json, file, if not already available. A package.json file is mostly used by npm to keep track of certain parameters in node projects, but this can be useful for other types of projects as well.

###docuement store
The package.json has the added bonus of being able to call script defined within in the "scripts" object.
This also creates and add to it 'set', 'get', and 'delete' scripts that allow you to treat the package.json as a document store using the following commands.

```bash
  npm run set -s <space delimited path to> <value>
  npm run get -s <space delimited path to> <value>
  npm run delete -s <space delimited path to remove>
```

#### git initilization-script
This will initialize a git repository (if not already initialized) and add appropriate github and gitlab remote addresses.

This will also add a post-commit command that will automatically tag the project with the latest version as updated in package.json

#### Docker Scripts
This will create sub-projects meant to be turned into docker images that lint, compile, demo, test, and deploy the main project. Please note that these sub-projects contain only "skeleton code" and must be configured before running

```bash
npm run build-images -s
```

Once the images are built,

This will create scripts within the package:

```bash
npm run lint -s
npm run compile -s
npm run demo -s
npm run test -s
npm run deploy -s
```
There are equalvalents to be run atop windows:

```bash
npm run lint-win -s
npm run compile-win -s
npm run demo-win -s
npm run test-win -s
npm run deploy-win -s
```

##### Setup images
The npm scripts are set up to mount an image and run a command from that image on a directory. Set up the "run" and "package.json" files appropriately.

###What's up with the "-s" after every npm run command?
It's not necessary, but it supresses some extra stuff from the npm command that aren't really necessary.
