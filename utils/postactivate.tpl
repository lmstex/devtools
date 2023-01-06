#!/usr/bin/zsh
# This hook is sourced after this virtualenv is activated.

export WRKSPACE=%%WRKSPACE%%
export PROJECT_TYPE=%%PROJECT_TYPE%%
export PROJUTILS=%%PROJUTILS%%

# Load any environment overrides 
proj_dir=$PROJECT_HOME/$WRKSPACE
projfile=$WORKON_HOME/$WRKSPACE/.project
if [ -f "$projfile" ]; then
  proj_dir=$(cat $projfile)
fi

export REPO_DIR=$proj_dir

env_file=$PROJUTILS/.env
if [ -f "$env_file" ]; then
  set -a
  . $env_file
  set +a
fi
