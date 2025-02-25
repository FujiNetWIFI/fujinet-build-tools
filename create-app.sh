#!/bin/bash
#set -x
#
# Creates an initial simple hello world application from template, with all required build files etc.
# Once created, you should be able to type "make" to fully compile for all targets the application.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# -ne 2 ] ; then
  echo "Usage: $(basename $0) APP_NAME PATH/TO/ROOT"
  echo "  APP_NAME     : name of directory created, and the app name for project"
  echo "  PATH/TO/ROOT : path to the folder that APP_NAME directory will be created in"
  exit 1
fi

APP_NAME="$1"
ROOT_DIR_PATH="$2"

if [ ! -d "${ROOT_DIR_PATH}" ] ; then
  echo "Could not find root directory to create app in. Please create it first to confirm it is correct"
  read -p "Do you want to create the directory now? (y/n): " choice
  if [[ ! "$choice" =~ ^(y|Y)$ ]] ; then
    echo "Exiting..."
    exit 1
  else
    mkdir -p "${ROOT_DIR_PATH}"
  fi
fi

TARGET_APP_DIR="${ROOT_DIR_PATH}/${APP_NAME}"

while [ -d "${TARGET_APP_DIR}" ] ; do 
  echo "Target directory ${TARGET_APP_DIR} already exists. Please move/delete it, or choose new name."
  read -p "New APP_NAME (leave blank to quit): " NEW_APP_NAME

  if [[ -z "${NEW_APP_NAME}" ]]; then
    exit 1
  fi

  APP_NAME="${NEW_APP_NAME}"
  TARGET_APP_DIR="${ROOT_DIR_PATH}/${APP_NAME}"
done 

echo "Creating ${TARGET_APP_DIR}"

# copy files into new project dir
cp -r "${SCRIPT_DIR}/template-app" "${TARGET_APP_DIR}"
sed "s#__TEMPLATE_APP__#${APP_NAME}#g" "${SCRIPT_DIR}/template-app/README.md" > "${TARGET_APP_DIR}/README.md"
cp -r makefiles "${TARGET_APP_DIR}/"
cp -r apple-tools "${TARGET_APP_DIR}/"

# create project Makefile
mv "${TARGET_APP_DIR}/makefiles/Makefile_sample_change" "${TARGET_APP_DIR}/Makefile"
sed -i.bu "s#__APP_NAME__#${APP_NAME}#g;s#__PARENT_RELATIVE_DIR__#.#g" "${TARGET_APP_DIR}/Makefile"
sed -i.bu "s#__PARENT_RELATIVE_DIR__#.#g" "${TARGET_APP_DIR}/makefiles/build.mk"
sed -i.bu "s#__PARENT_RELATIVE_DIR__#.#g" "${TARGET_APP_DIR}/makefiles/common.mk"
sed -i.bu "s#__PARENT_RELATIVE_DIR__#.#g" "${TARGET_APP_DIR}/makefiles/custom-apple2.mk"

# remove any backup files created by sed because macos
find "${TARGET_APP_DIR}" -name \*.bu -exec rm {} \;
