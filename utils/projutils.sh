
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
  
  less -R $PROJUTILS/README
}

function proj-home {
  cd $PROJECT_HOME
}

function proj-cd {
  
  local name=$1
  [ -z "$name" ] && \
    echo "Please specify the name of the project" && \
    return 1

  ! workon | grep $name && \
    echo "Project '$name' does not exist" && \
    return 1

  cd $PROJECT_HOME/$name

}

_init
