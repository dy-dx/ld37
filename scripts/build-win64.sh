#!/bin/bash

SCRIPTS_DIR=$(cd `dirname $0` && pwd)
PROJECT_DIR=$(dirname $SCRIPTS_DIR)

cd $PROJECT_DIR

rm -rf tmp
mkdir tmp && cd tmp

unzip ../scripts/love-0.10.2-win64.zip
mv love-0.10.2-win64 SpacePals
cp ../dist/SpacePals.love SpacePals/

cd SpacePals
cat love.exe SpacePals.love > SpacePals.exe
rm SpacePals.love love.exe lovec.exe changes.txt readme.txt game.ico love.ico

cd ..
zip -9 -r spacepals-win64 SpacePals

cd $PROJECT_DIR
mv tmp/spacepals-win64.zip dist/
