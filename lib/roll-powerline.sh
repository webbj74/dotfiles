#!/usr/bin/env bash

SCRIPT_NAME=$(basename $0)
SCRIPT_LIB="$(cd "$(dirname $(dirname $0))/lib"; pwd)"

# Include the common function definitions for all scripts
source "${SCRIPT_LIB}/common.bash"
source "${SCRIPT_LIB}/dotfiles.bash"

function update_powerline_software {
  cd "${HOME}/src" 
  rm -rf powerline-shell
  git clone git@github.com:milkbikis/powerline-shell.git
  cp -v "${SCRIPT_ROOT}/common/powerline-shell.py" "${HOME}/src/powerline-shell/"
  if [ ! -f "${HOME}/Library/Fonts/Anonymice Powerline.ttf" ]; then
    open "${SCRIPT_ROOT}/fonts/AnonymousPro/Anonymice Powerline.ttf"
  fi
  /usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Normal Font' AnonymicePowerline 18" ~/Library/Preferences/com.googlecode.iTerm2.plist
  /usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Non Ascii Font' AnonymicePowerline 18" ~/Library/Preferences/com.googlecode.iTerm2.plist
}

update_powerline_software

