#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# See: driesvints/dotfiles

# Load from setup.d
if [[ -d "${DOTFILES_DIR}/setup.d/" ]]; then
  echo "Found setup dirs"
  for SETUP_FILE in ${DOTFILES_DIR}/setup.d/*.shinc ; do
    echo "Processing ${SETUP_FILE}"
    if [[ -f "${SETUP_FILE}" ]] ; then
      source "${SETUP_FILE}"
    fi
  done
fi
