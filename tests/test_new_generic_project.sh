#!/usr/bin/env zsh

function cleanup {
  
  proj-rm $1
  return 0

}

function error {
  echo "${RED} ERROR: ${NC}$1"
  echo "${RED} FAILED ${NC}"
  cleanup
}

function test_new_generic_project {

  # TODO: We should be able to set the project_home to any other location, not just
  # the $PROJECT_HOME
  local project_home=$PROJECT_HOME

  #Command for generating to proj utility
  local command="PROJECT_HOME=$project_home proj-new"
  
  # Build a new project (defaults)
  local proj_name="testproj"
  ! eval "$command $proj_name" && \
    error "Project creation command '$command $proj_name' failed" && \
    return 1

  local proj_dir=$project_home/$proj_name

  [ ! -d "$proj_dir" ] && \
    error "Project directory does not exist" && \
    return 1

  [ -z "$REPO_DIR" ] && \
    error "REPO_DIR env var is not defined" && \
    return 1

  [ "$REPO_DIR" != "$proj_dir" ] && \
    error "REPO_DIR does not match the location of the project" && \
    return 1

  ! type "warn" &>/dev/null && \
    error "warn function not defined" && \
    return 1

  ! type "error" &>/dev/null && \
    error "error function not defined" && \
    return 1

  ! type "info" &>/dev/null && \
    error "info function not defined" && \
    return 1

  ! type "hint" &>/dev/null && \
    error "hint function not defined" && \
    return 1

  local proj_file 
  local files=( mkdocs.yml .proj .gitignore README.md LICENSE requirements.txt TODO.md )
  for f in "${files[@]}"; do
    proj_file="$proj_dir/$f"
    [ ! -f "$proj_file" ] && \
      error "Project file '$proj_file' does not exist" && \
      return 1
  done

  local dirs=( tests docs ) 
  local dir
  for d in "${dirs[@]}"; do
    dir="$proj_dir/$d"
    [ ! -d "$dir" ] && \
      error "Directory '$dir' does not exist" && \
      return 1
  done

  echo "${GREEN} PASSED ${NC}"
  return 0
}

test_new_generic_project

