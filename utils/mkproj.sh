#!/usr/bin/env bash

# Check the virtualenv was loaded
[ -z $REPO_DIR ] && \
  echo "Environment was not sourced" && \
  exit 1

# Initialise the git repository
git init $REPO_DIR

# Add a project specific settings file
touch $REPO_DIR/.proj

# Documentation directory
[ -d $REPO_DIR/tests ] || mkdir $REPO_DIR/tests

# Readme, todo and license files
cp $PROJUTILS/templates/generic/README.md \
   $PROJUTILS/templates/generic/TODO.md \
   $PROJUTILS/templates/generic/.gitignore \
   $PROJUTILS/templates/generic/LICENSE $REPO_DIR

pip install --upgrade pip
if ! pip list | grep -q mkdocs; then
  pip install mkdocs virtualenvwrapper
  mkdocs new $REPO_DIR
fi

# Install the project type specific tools (e.g python tools, C, etc...)
install=$PROJUTILS/templates/$PROJECT_TYPE/install.sh
[ -f "$install" ] && $install

