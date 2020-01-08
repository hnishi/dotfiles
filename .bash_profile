#set -xv

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
  fi
fi

# 個々の環境のbash設定を読み込む
if [ -e "${HOME}/.bashrc_local" ]; then
  source "${HOME}/.bashrc_local"
fi

# OS ごとの設定を読み込む
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='freebsd'
fi

echo your platform is $platform

if [[ $platform == 'linux' ]]; then
  source "${HOME}/.bashrc_linux"
elif [[ $platform == 'freebsd' ]]; then
  source "${HOME}/.bashrc_mac"
fi

export PATH=$HOME/.local/bin:$PATH

# completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# TODO: add PS1 here

