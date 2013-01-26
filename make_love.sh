#!/bin/bash

FILENAMEBASE=Bacteria-v0.1

FINDCMD="find . -false" # warning: quoted paths are escaped in a weird way by bash, breaking the find commandline
FINDCMD="$FINDCMD -o -wholename ./.git -prune"
FINDCMD="$FINDCMD -o -wholename ./build -prune"
FINDCMD="$FINDCMD -o -wholename ./synctoweb.sh -prune"
FINDCMD="$FINDCMD -o -wholename ./make_love.sh -prune"
FINDCMD="$FINDCMD -o -print"

rm -f build/${FILENAMEBASE}.love build/${FILENAMEBASE}.exe build/${FILENAMEBASE}-src.zip
#~ echo `$FINDCMD`
#~ echo "-------------"
zip /tmp/${FILENAMEBASE}.zip `$FINDCMD`
cp /tmp/${FILENAMEBASE}.zip build/${FILENAMEBASE}-src.zip
mv /tmp/${FILENAMEBASE}.zip build/${FILENAMEBASE}.love
cat build/love/love.exe build/${FILENAMEBASE}.love > build/${FILENAMEBASE}.exe

# make zip for windows with .exe and love dlls + readme
cd build
rm -rf ${FILENAMEBASE}/
mkdir -p ${FILENAMEBASE}/
mv ${FILENAMEBASE}.exe ${FILENAMEBASE}/
cp love/* ${FILENAMEBASE}/
rm ${FILENAMEBASE}/love.exe
cp ../README.txt ${FILENAMEBASE}/
rm -rf ${FILENAMEBASE}.zip
zip ${FILENAMEBASE}.zip ${FILENAMEBASE}/*
rm -rf ${FILENAMEBASE}/
