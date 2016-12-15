#!/bin/bash

SCRIPTS_DIR=$(cd `dirname $0` && pwd)
PROJECT_DIR=$(dirname $SCRIPTS_DIR)

cd $PROJECT_DIR

rm -rf tmp
mkdir tmp && cd tmp

unzip ../scripts/SpacePals.zip
cp ../dist/SpacePals.love ./SpacePals.app/Contents/Resources/

zip -9 -r spacepals-osx SpacePals.app

cd $PROJECT_DIR
mv tmp/spacepals-osx.zip dist/
