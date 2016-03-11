function _powerline_ps1() {
  export PS1="$( "${HOME}/src/powerline-shell/powerline-shell.py" --mode patched $? 2> /dev/null )"
}

