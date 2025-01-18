#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
CACHE_DIR=$(realpath ${SCRIPT_DIR}/../_cache)

AC_VER="1.9.0"
export AC="java -jar ${CACHE_DIR}/AppleCommander-ac-${AC_VER}.jar"
export ACX="java -jar ${CACHE_DIR}/AppleCommander-acx-${AC_VER}.jar"

# this also fetches ProDOS. meh.
if [ ! -f "$CACHE_DIR}/ProDOS_2_4_2.dsk" ]; then
  curl -s -L -o "$CACHE_DIR/ProDOS_2_4_2.dsk" "https://mirrors.apple2.org.za/ftp.apple.asimov.net/images/masters/prodos/ProDOS_2_4_2.dsk"
fi

if [ ! -f "$CACHE_DIR/AppleCommander-ac-${AC_VER}.jar" ]; then
  curl -s -L -o "$CACHE_DIR/AppleCommander-ac-${AC_VER}.jar" "https://github.com/AppleCommander/AppleCommander/releases/download/${AC_VER}/AppleCommander-ac-${AC_VER}.jar"
  curl -s -L -o "$CACHE_DIR/AppleCommander-acx-${AC_VER}.jar" "https://github.com/AppleCommander/AppleCommander/releases/download/${AC_VER}/AppleCommander-acx-${AC_VER}.jar"
fi
