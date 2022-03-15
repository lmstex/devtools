#!/usr/bin/zsh
# This hook is sourced after this virtualenv is activated.

export REPO_DIR=$PROJECT_HOME/%%WRKSPACE%%
export WRKSPACE=%%WRKSPACE%%
export PROJECT_TYPE=%%PROJECT_TYPE%%
export PROJUTILS=%%PROJUTILS%%

env_file=$PROJUTILS/.env
if [ -f "$env_file" ]; then
  set -a
  . $env_file
  set +a
fi
