function _setup_docker_completion() {
  local srcdir="$HOME/.zprezto/modules/completion/external/src/"
  if (( ! $+commands[docker] )); then
    return
  fi
  if [ -d $srcdir -a ! -f "${srcdir}/_docker" ]; then
    docker completion zsh > "${srcdir}/_docker"
  fi
}
_setup_docker_completion