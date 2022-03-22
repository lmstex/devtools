#!/usr/bin/env bash
#
# This  script automatically creates a tmux environment for the workspace specified
# in the first argument.
#

function start_devenv() {

  local devenv_dir=""

  echo "Starting the DEVENV development workspace"

  tmux new-session -s devenv \; \
   rename-window "DEVENV" \; send-keys "workon devenv; vim" C-m C-l \; \
    split-window \; send-keys "workon devenv" C-m C-l \; \
   new-window -n "DEVENV DOCS" \; send-keys "workon devenv" C-m C-l \; \
    split-window \; send-keys "workon devenv" C-m C-l \; \
   new-window -n misc \; \
   select-window -t "DEVENV" \; \
  attach
}
