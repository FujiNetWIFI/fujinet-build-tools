#!/bin/bash
#set -x
#
# Creates a multi-project folder structure and initial simple hello world application from template, with all required build files etc.
# Once created, you should be able to cd into the starter app folder and type "make" to fully compile for all targets of the application.

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# -ne 3 ] ; then
  echo "Usage: $(basename $0) PROJECT_NAME FIRST_APP_NAME PATH/TO/ROOT_FOLDER"
  echo "  PROJECT_NAME        : name of root directory created, e.g. 'network-tools'"
  echo "  FIRST_APP_NAME      : name of the first app created, e.g. 'hello-world'"
  echo "  PATH/TO/ROOT_FOLDER : path to the folder that PROJECT_NAME will be created in, that will contain FIRST_APP_NAME sub-directory, and additional tooling to build"
  exit 1
fi

PROJECT_NAME="$1"
FIRST_APP_NAME="$2"
ROOT_DIR_PATH="$3"

if [ ! -d "${ROOT_DIR_PATH}" ] ; then
  echo "Could not find root directory to create app in."
  read -p "Do you want to create the directory now? (y/n): " choice
  if [[ ! "$choice" =~ ^(y|Y)$ ]] ; then
    echo "Exiting..."
    exit 1
  else
    mkdir -p "${ROOT_DIR_PATH}"
  fi
fi

TARGET_PROJECT_DIR="${ROOT_DIR_PATH}/${PROJECT_NAME}"

while [ -d "${TARGET_PROJECT_DIR}" ] ; do 
  echo "Target directory ${TARGET_PROJECT_DIR} already exists. Please move/delete it, or choose new name."
  read -p "New APP_NAME (leave blank to quit): " NEW_APP_NAME

  if [[ -z "${NEW_PROJECT_NAME}" ]]; then
    exit 1
  fi

  PROJECT_NAME="${NEW_PROJECT_NAME}"
  TARGET_PROJECT_DIR="${ROOT_DIR_PATH}/${PROJECT_NAME}"
done 

echo "Creating ${PROJECT_NAME}"
mkdir -p "${TARGET_PROJECT_DIR}"

# copy files into first app dir
cp -r "${SCRIPT_DIR}/template-app" "${TARGET_PROJECT_DIR}/${FIRST_APP_NAME}"
sed "s#__TEMPLATE_APP__#${FIRST_APP_NAME}#g" "${SCRIPT_DIR}/template-app/README.md" > "${TARGET_PROJECT_DIR}/${FIRST_APP_NAME}/README.md"
cp -r makefiles "${TARGET_PROJECT_DIR}/"
cp -r apple-tools "${TARGET_PROJECT_DIR}/"
mv "${TARGET_PROJECT_DIR}/${FIRST_APP_NAME}/.gitignore" "${TARGET_PROJECT_DIR}/"

# create project Makefile
mv "${TARGET_PROJECT_DIR}/makefiles/Makefile_sample_change" "${TARGET_PROJECT_DIR}/${FIRST_APP_NAME}/Makefile"
sed -i.bu "s#__APP_NAME__#${FIRST_APP_NAME}#g;s#__PARENT_RELATIVE_DIR__#..#g" "${TARGET_PROJECT_DIR}/${FIRST_APP_NAME}/Makefile"
sed -i.bu "s#__PARENT_RELATIVE_DIR__#..#g" "${TARGET_PROJECT_DIR}/makefiles/build.mk"
sed -i.bu "s#__PARENT_RELATIVE_DIR__#..#g" "${TARGET_PROJECT_DIR}/makefiles/common.mk"
sed -i.bu "s#__PARENT_RELATIVE_DIR__#..#g" "${TARGET_PROJECT_DIR}/makefiles/custom-apple2.mk"

# remove any backup files created by sed because macos
find "${TARGET_PROJECT_DIR}" -name \*.bu -exec rm {} \;
