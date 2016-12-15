#!/bin/bash

SCRIPTS_DIR=$(cd `dirname $0` && pwd)
PROJECT_DIR=$(dirname $SCRIPTS_DIR)

cd $PROJECT_DIR/src
zip -9 -r SpacePals.love .
cd ..
rm -rf bin
mkdir bin
cd bin
unzip ../scripts/SpacePals.zip
mv ../src/SpacePals.love ./SpacePals.app/Contents/Resources/

