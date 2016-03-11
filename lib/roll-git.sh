#!/usr/bin/env bash

SCRIPT_NAME=$(basename $0)
SCRIPT_LIB="$(cd "$(dirname $(dirname $0))/lib"; pwd)"

# Include the common function definitions for all scripts
source "${SCRIPT_LIB}/common.bash"
source "${SCRIPT_LIB}/dotfiles.bash"

function update_git_software {
    # Check for Homebrew
    if [ "$(which brew)" ]; then
        brew update 2> /dev/null
        brew reinstall git 2> /dev/null
        brew reinstall git-lfs 2> /dev/null
        brew cleanup git git-lfs 2> /dev/null
    fi
}

function update_git_dotfiles {
    local i=0
    local gitDotfiles=(
        "gitconfig"
        "gitignore-global"
    )

    for ((i=0; i<${#gitDotfiles[@]}; ++i)) do
        recreate_dotfile "${gitDotfiles[$i]}"
    done
}

function update_git_shellenv {
    echo
}

function update_git_personal {
    msg="Appending to ~/.gitconfig with info from ~/.dotfilesrc"
    scriptMessage "${msg}"
    echo -e "\n# ${msg}\n" >> "${HOME}/.gitconfig"

    git config --global user.name "${DOTFILES_REALNAME}"
    git config --global user.email "${DOTFILES_EMAIL}"
    git config --global github.user "${DOTFILES_GITHUBBER}"
}

update_git_software
update_git_dotfiles
update_git_shellenv
update_git_personal
dotfiles_source_nag
