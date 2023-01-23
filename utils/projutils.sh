
function _init {

  export PROJUTILS=${PROJUTILS:-%%PROJUTILS%%}

  local _ssh_env=${SSH_ENV:-"$HOME/.ssh/.agent"}
  
  if [ -f "$_ssh_env" ]; then
    . $_ssh_env &>/dev/null
    ps -ef | grep "${SSH_AGENT_PID}" | grep ssh-agent$ &>/dev/null || \
      _start_ssh_agent $_ssh_env
  else
    _start_ssh_agent $_ssh_env
  fi

  return 0 
}

function _start_ssh_agent {
  local k
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' > $1
  chmod 600 "$1"
  . $1
  [ -n "$SSH_KEYS" ] && \
    for k in "${SSH_KEYS[@]}"; do ssh-add $k &>/dev/null; done
}


function proj-new {

  local name=$1
  [ -z "$name" ] && \
    echo "Please specify the name of the project" && \
    return 1

  export WRKSPACE=$name
  mkproject $name && \
    echo "Generic project '$name' successfully created" && \
    return 0

  echo "Project generation failed"
  return 1
}

function proj-import {

  # Imports an existing project into a GENERIC projutils project. 
  
  # Updates an existing project to become an projutils project
  [ -z "$1" ] && \
    echo "Please specify the directory of the project to include" && \
    return 1

  local proj_dir=$(realpath -e $1)
  if [ "$?" != "0" ]; then
    echo "The '$proj_dir' directory does not exist"
    return 1
  fi

  local proj_name=$(basename $proj_dir)
  local proj_parent_dir=$(dirname $proj_dir)

  local tmp_dir=$(mktemp -d)
  mv $proj_dir $tmp_dir &>/dev/null || \
    { echo "ERR1: Failed to import the project. Move operation failed." && \
      return 1; }

  export WRKSPACE=$proj_name
  if [ "$PROJECT_HOME" != "$proj_parent_dir" ]; then
    # For project that are not located in the $PROJECT_HOME directory
    CUSTOM_PROJECT_HOME=$proj_parent_dir \
    PROJECT_HOME=$proj_parent_dir \
      mkproject $proj_name
  else
    mkproject $proj_name
  fi
  [ "$?" = "0" ] || \
    { echo "ERR2: Failed to create project '$proj_name'." &&  return 1; }

  [ ! -d "$proj_dir" ] && \
    { echo "ERR3: Failed to import project" && \
      return 1; }

  cp -R $tmp_dir/. $proj_dir
  rm -rf $tmp_dir

  echo "project '$proj_name' imported"

}

function proj-wrk {

  local name=$1
  [ -z "$name" ] && \
    echo "Please specify the name of the project" && \
    return 1

  ! workon | grep $name && \
    echo "Project '$name' does not exist" && \
    return 1

  workon $name && \
    echo "Working on project '$name'" && \
    return 0

  echo "Cannot work on project '$name'"
  return 1

}

function proj-leave {

  [ -z "$VIRTUAL_ENV" ] && \
    echo "Not working on any project managed by projutils" && \
    return 1

  local name=$(basename $VIRTUAL_ENV)

  deactivate && \
    echo "Exiting work on project '$name'" && \
    exit 0

  echo "Cannot leave project '$name'"
  return 1

}

function proj-rm {
  
  local name=$1
  [ -z "$name" ] && \
    echo "Please specify the name of the project" && \
    return 1

  ! workon | grep $name && \
    echo "Project '$name' does not exist" && \
    return 1

  if [ -n "$VIRTUAL_ENV" ]; then
    local env_proj=$(basename $VIRTUAL_ENV)
    if [ "$env_proj" = "$name" ]; then
      deactivate
    fi
  fi 
  
  rm -rf $PROJECT_HOME/$name && \
    rmvirtualenv $name && \
    echo "Project '$name' was deleted" && \
    return 0

  echo "Failed to delete project '$name'"
  return 1
  
}

function proj-update {

  local updater=$(readlink $PROJUTILS/update) 
  $updater && return 0

  echo "Failed to update proj utils"
  return 1
  
}

function proj-version {
  
 cat $PROJUTILS/VERSION
}

function proj-help {

  local placeholder="%%PROJ_DOCUMENTATION%%"
  local gen_read_file=$PROJUTILS/README
  local tmp_dir="/tmp" tmp_file
  local lines_count=$(wc -l $gen_read_file | cut -d \  -f 1)
  local proj_doc=${WRKSPACE}_docs

  if [ -d "$REPO_DIR/.local/tmp" ]; then
    tmp_dir=$REPO_DIR/.local/tmp
  fi 
  tmp_file=$tmp_dir/$(basename $gen_read_file)

  if type "$proj_doc" &>/dev/null; then
    local placeholder_line=$(grep -n "${placeholder}$" $gen_read_file | cut -d ':' -f 1)

    if [ -n "$placeholder_line" ]; then
      head -n $(( $placeholder_line - 1 )) $gen_read_file > $tmp_file
      echo " " >> $tmp_file
      $proj_doc >> $tmp_file
      echo " " >> $tmp_file
      tail -n $(( $lines_count - $placeholder_line )) $gen_read_file >> $tmp_file
    else
      echo "No project documentation placeholder marker in usage.txt file"
    fi
  else
    sed "s/$placeholder//g" $gen_read_file > $tmp_file
  fi 
  
  less -R $tmp_file
}

function proj-home {
  cd $PROJECT_HOME
}

function proj-cd {
  
  local name=$1
  if [ -z "$name" ]; then
    if [ -n "$REPO_DIR" ]; then
      cd $REPO_DIR
      return 0
    fi
    echo "Please specify the name of the project"
    return 1
  fi

  ! workon | grep $name && \
    echo "Project '$name' does not exist" && \
    return 1

  cd $PROJECT_HOME/$name

}

function proj-docker-prune {
  docker system prune
}

_init
