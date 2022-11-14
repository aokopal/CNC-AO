#!/bin/bash

echo "Starting deploy process..."

echo "Packaging build"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR
cd ..

PACKAGE_ROOT=$(pwd)

rm -rf dist
mkdir dist

rm -rf build
mkdir build

cp -r src build

cd build

tar cf ../dist/CNC-AO.tar src
gzip ../dist/CNC-AO.tar

echo "Packaging complete"


echo "Ready to deploy"

if [ -z "$1" ]; then
    echo "Where should I deploy?"
    read DEST_HOST
else
    DEST_HOST=$1
fi

echo "Deploying to: $DEST_HOST"

scp dist/CNC-AO.tar.gz $DEST_HOST:/tmp
ssh $DEST_HOST 'rm -rf ~/CNC-AO/* ; tar zxf /tmp/CNC-AO.tar.gz -C ~/ ; rm -f /tmp/CNC-AO.tar.gz'

echo "Deployed"

exit 0