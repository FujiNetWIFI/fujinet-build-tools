# fujinet-build-tools

A repo of help scripts, jar files, makefile help scripts for building apps in 2024.

## Creating a new app from the template

To create a new app based on the template with a hello world style base, run following

```shell
./create-app.sh YOUR_APP_NAME path/to/root-dir
```

This will create `YOUR_APP_NAME` in `path/to/root-dir/YOUR_APP_NAME/` with a fully buildable application.

```shell
cd path/to/root-dir/YOUR_APP_NAME/
make
```

## AtariSIO

- src to build dir2atr used to create Atari ATR disk images.
- cd AtariSIO/tools
- sudo make -f Makefile.posix install

## AppleTools

- files used to create Apple2 bootable PO disk images

## Makefiles

- @fenrocks makefile scripts for building cc65 targets
- copy the sample Makefile to your own local FujiNet project, replace the standard cc65 Makefile
- edit the path back to this repo
- enjoy the features of the FUFMF - Fenrocks Ultimate Fuji Make Files
