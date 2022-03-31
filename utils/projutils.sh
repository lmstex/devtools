
function _init {

  export PROJUTILS=${PROJUTILS:-%%PROJUTILS%%} return 0 }

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
