#!/usr/bin/env bash

# Proj utils installation/update script
#
# Tools are installed in the .local/share/projutils directory.

function install-vim {
  return 0
}

function install-tmux {
  return 0
}

function update-file {

  local begin="# @@Projutils"
  local end="# @@ProjutilsEnd"
  local repo_file=$1
  local dest_file=$2
  local first_eof=$(grep -n "${begin}$" $dest_file | cut -d ':' -f 1)
  local end_eof=$(grep -n "${end}$" $dest_file | cut -d ':' -f 1)

  if [ -n "$first_eof" ] && [ -n "$end_eof" ]; then
    head -n $first_eof $dest_file > /tmp/head
    echo " " > /tmp/tail
    tail -n $(( $(wc -l $dest_file | cut -d \  -f 1) - $end_eof + 1 )) $dest_file >> /tmp/tail
    cat /tmp/head $repo_file /tmp/tail > $dest_file
  elif [ -n "$first_eof" ] || [ -n "$end_eof" ]; then
    echo "File '$dest_file' is corrupted" 
    return 1
  else
    echo " " >> $dest_file
    echo $begin >> $dest_file
    cat $repo_file >> $dest_file
    echo $end >> $dest_file
    echo " " >> $dest_file
  fi

  return 0 
}

function install-utils {
  
  local install_dir=$HOME/.local/share/projutils 
  local repo_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

  # Check the mkvirtualenv is available (currently this tools reliws on the
  # mkvirtualenv package) 
  if [ -z "$VIRTUALENVWRAPPER_HOOK_DIR" ]; then
    echo "Please install the mkvirtualenv tool first"
    echo "Exiting..."
    exit 1
  fi

  [ -d "$install_dir" ] && rm -rf $install_dir
  mkdir -p $install_dir

  # The installation is based on links to the repository 
  # (this makes it easier to change things on the spot)
  ln -s $repo_dir/utils/.env $install_dir/.env
  ln -s $repo_dir/utils/postactivate.tpl $install_dir/postactivate.tpl
  ln -s $repo_dir/utils/usage.txt $install_dir/README
  ln -s $repo_dir/version $install_dir/VERSION
  ln -s $repo_dir/install.sh $install_dir/update
  ln -s $repo_dir/utils/mkproj.sh $install_dir/mkproj.sh
  #ln -s $repo_dir/utils/projutils.sh $install_dir/projutils
  sed "s|%%PROJUTILS%%|$install_dir|g" $repo_dir/utils/projutils.sh > $install_dir/projutils
  ln -s $repo_dir/templates $install_dir/templates

  #Update the mkvirtualenv files
  local dest src f files=( postmkproject )
  for f in "${files[@]}"; do
    src=$repo_dir/utils/$f
    dest="$VIRTUALENVWRAPPER_HOOK_DIR/$f"
    update-file $src $dest
  done

  #Update .zshrc file if any, or .bashrc if any
  local cmd=". $install_dir/projutils"
  src="/tmp/shell"
  dest="$HOME/.$(basename ${SHELL})rc"
  echo "$cmd" >> $src
  update-file $src $dest
  rm $src

}

install-utils
install-vim
install-tmux

echo "Projutils successfully installed - reload $(basename $SHELL)"
