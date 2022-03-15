#!/usr/bin/env bash

function test_new_generic_project {

  local project_home=/tmp

  #Command for generating to proj utility
  local command="PROJECT_HOME=$project_home mkproject"
  
  # Build a new project (defaults)
  local proj_name="testproj"
  ! eval $command $proj_name && \
    echo "Project creation command '$command $proj_name' failed" && \
    return 1

  local proj_dir=$project_home/$proj_name

  [ ! -d "$proj_dir" ] && \
    echo "Project directory does not exist" && \
    return 1

  [ -z "$REPO_DIR" ] && \
    echo "REPO_DIR env var is not defined" && \
    return 1

  [ "$REPO_DIR" != "$proj_dir" ] && \
    echo "REPO_DIR does not match the location of the project" && \
    return 1

  ! type "warn" &>/dev/null && \
    echo "warn function not defined" && \
    return 1

  ! type "error" &>/dev/null && \
    echo "error function not defined" && \
    return 1

  ! type "info" &>/dev/null && \
    echo "info function not defined" && \
    return 1

  ! type "hint" &>/dev/null && \
    echo "hint function not defined" && \
    return 1

  local proj_file 
  local files=( mkdocs.yml .proj .gitignore README.md LICENSE requirements.txt TODO.md )
  for f in "${files[@]}"; do
    proj_file="$proj_dir/$f"
    [ ! -f "$proj_file" ] && \
      echo "Project file '$proj_file' does not exist" && \
      return 1
  done

  local dirs=( tests docs ) 
  local dir
  for d in "${dirs[@]}"; do
    dir="$proj_dir/$d"
    [ ! -d "$dir" ] && \
      echo "Directory '$dir' does not exist" && \
      return 1
  done

# Utility to create a new GENERIC project
#proj --type=generic new

  echo "${GREEN} PASSED ${NC}"
  return 0
}


