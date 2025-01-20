# fujinet-build-tools

A repo of help scripts, makefile scripts, and template application for building apps in 2024 and beyond.

Note, the makefiles are mostly templated with __PLACEHOLDER_VARIABLES__ that the create-* scripts will replace with the correct values.
So if you wish to use them manually, you will need to adjust them to your needs.

## Creating a new app

To create a new app based on the template with a hello world style base, run the following command in a shell

```shell
$ ./create-app.sh YOUR_APP_NAME path/to/root-dir
```

This will create the folder `path/to/root-dir/YOUR_APP_NAME/` with a fully buildable application.

```shell
# example, create a fn-hello-world single app at ../fn-hello-world/
$ ./create-app.sh fn-hello-world ..
```

```shell
cd path/to/root-dir/YOUR_APP_NAME/
make

# and commit it to git
git init .
git add -A
git commit -m 'initial commit'
```

## Creating a multi-application project

Similar to create-app.sh, you can instead use `create-multi.sh` to create a multi-application project.

```shell
$ ./create-multi.sh YOUR_PROJECT_NAME YOUR_FIRST_APP_NAME path/to/root-dir
```

This will create the folder `path/to/root-dir/YOUR_PROJECT_NAME/` with a fully buildable application in the subfolder `YOUR_FIRST_APP_NAME`.

```shell
# example, create a fn-new-tools multi-app project in the parent directory, i.e. '../fn-new-tools/fn-app-1' with tooling in '../fn-new-tools'
$ ./create-multi.sh fn-new-tools fn-app-1 ..
```

### src folders

A full explanation of the src folder structure of the template app, and how build.mk includes files is explained
in the [src README.md](template-app/src/README.md).

## AtariSIO

- src to build dir2atr used to create Atari ATR disk images.
- cd AtariSIO/tools
- sudo make -f Makefile.posix install

## AppleTools

- files used to create Apple2 bootable PO disk images

## Makefiles

These are `@fenrock`'s makefile scripts for building cc65 targets.

Use the `create-app.sh` file detailed above which will generate a new project
from the template app, including the makefiles, and prepare a full hello world application
with full cross platform directory structure built into it.
