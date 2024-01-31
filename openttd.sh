#!/bin/zsh

SCRIPT_DIR=$(dirname $0)

cp -R $SCRIPT_DIR/../OpenTTD /Users/$USER/Documents/
/Users/$USER/Library/$1/OpenTTD/build/openttd
rm -rf /Users/$USER/Documents/OpenTTD
