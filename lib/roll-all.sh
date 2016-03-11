#!/bin/bash

SCRIPT_NAME=$(basename $0)
SCRIPT_LIB="$(cd "$(dirname $(dirname $0))/lib"; pwd)"

# Include the common function definitions for all scripts
source "${SCRIPT_LIB}/common.bash"
source "${SCRIPT_LIB}/dotfiles.bash"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

function resetDirectory
{
    local dir=$1
    scriptMessage "Resetting ${dir}"
    mkdir -pv "${dir}"
    find "${dir}" -type f -exec rm -v "{}" \; | sed -e 's/^/removing /'
}

# Create dir for sourcing profile.
resetDirectory "${HOME}/.profile.d"

# Create dir for sourcing bash config.
resetDirectory "${HOME}/.bashrc.d"

scriptMessage "Recreating ~/.profile"
cp -v "${SCRIPT_ROOT}/profile" "${HOME}/.profile"
echo -e "\nPATH=\"\$PATH:${SCRIPT_BIN}\"\n" >>  "${HOME}/.profile"

scriptMessage "Recreating ~/.bashrc"
cp -v "${SCRIPT_ROOT}/bashrc" "${HOME}/.bashrc"

# Global Brews
if [ -z "$(which brew)" ]; then
  scriptMessage "Installing homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
scriptMessage "Updating brews"
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew update
brew upgrade --all


for ((i=0; i<${#DOTFILES_DIRS[@]}; ++i)) do
  BREW_SCRIPT="${SCRIPT_ROOT}/${DOTFILES_DIRS[$i]}/brews.sh"
  if [ -f "${BREW_SCRIPT}" ]; then
    scriptMessage "Updating ${BREW_SCRIPT} brews..."
    ${BREW_SCRIPT} 2>/dev/null
  fi

  PROFILE_D="${SCRIPT_ROOT}/${DOTFILES_DIRS[$i]}/profile.d"
  if [ -d "${PROFILE_D}" ]; then
    scriptMessage "Updating ~/.profile.d from ${PROFILE_D}"
    for config in ${PROFILE_D}/*.sh ; do
      if [ -f "${config}" ] ; then
        cp -v "${config}" ~/.profile.d
      fi
    done
  fi

  BASHRC_D="${SCRIPT_ROOT}/${DOTFILES_DIRS[$i]}/bashrc.d"
  if [ -d "${BASHRC_D}" ]; then
    scriptMessage "Updating ~/.bashrc.d from ${BASHRC_D}"
    for config in ${BASHRC_D}/*.sh ; do
      if [ -f "${config}" ] ; then
        cp -v "${config}" ~/.bashrc.d
      fi
    done
  fi

  OSX_SCRIPT="${SCRIPT_ROOT}/${DOTFILES_DIRS[$i]}/osx.sh"
  if [ -f "${OSX_SCRIPT}" ]; then
    scriptMessage "Resetting OSX defaults from ${OSX_SCRIPT}"
    "${OSX_SCRIPT}"
  fi
done

php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '41e71d86b40f28e771d4bb662b997f79625196afcca95a5abf44391188c695c6c1456e16154c75a211d238cc3bc5cb47') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

"${SCRIPT_BIN}/roll-git"
