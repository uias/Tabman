#!/bin/sh

WORKING_DIR=${BASH_SOURCE%/*}
GEN_DIR=$WORKING_DIR/gen

if [[ $# -eq 0 ]] ; then
    echo 'No output directory specified'
    exit 1
fi

curl https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json | ruby $WORKING_DIR/parse.rb
cp -rf $GEN_DIR $1
rm -rf $GEN_DIR
echo 'Moving generated files to' $1