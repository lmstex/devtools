#!/usr/bin/env bash

# Base package
mkdir $REPO_DIR/$WRKSPACE
touch $REPO_DIR/$WRKSPACE/__init__.py

_pwd=$(dirname $0)
for f in $(ls $_pwd/wrkdir); do
  sed "s/%%WRKSPACE%%/$WRKSPACE/g" $f > $REPO_DIR/$(basename $f)
done
