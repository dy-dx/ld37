#!/bin/bash

SCRIPTS_DIR=$(cd `dirname $0` && pwd)
PROJECT_DIR=$(dirname $SCRIPTS_DIR)

cd $PROJECT_DIR

mkdir -p dist
rm -rf dist/SpacePals.love
cd src && zip -0 -r SpacePals.love .
cd ..
mv src/SpacePals.love dist/

$SCRIPTS_DIR/build-osx.sh
$SCRIPTS_DIR/build-win64.sh
