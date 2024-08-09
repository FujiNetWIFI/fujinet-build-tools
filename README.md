# fujinet-build-tools

A repo of help scripts, makefile scripts, and template application for building apps in 2024 and beyond.

## Creating a new app

To create a new app based on the template with a hello world style base, run the following command in a shell

```shell
./create-app.sh YOUR_APP_NAME path/to/root-dir
```

This will create the folder `path/to/root-dir/YOUR_APP_NAME/` with a fully buildable application.

```shell
cd path/to/root-dir/YOUR_APP_NAME/
make

# and commit it to git
git init .
git add -A
git commit -m 'initial commit'
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

You can manually copy these files to a new project, or use the `create-app.sh` file detailed above which will generate a new project
from the template app, including the makefiles, and prepare a full hello world application, with full cross platform directory structure
built into it.

Honestly, it's easier to use the `create-app.sh` script above to create your project.
