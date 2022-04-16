# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
  fi
fi

# 毎回シェルで Screen を起動する
# https://wiki.archlinux.jp/index.php/GNU_Screen
#if [[ -z "$STY" ]]; then
#   screen -xRR z_default_session
#fi

# pyenv
# See https://github.com/pyenv/pyenv#basic-github-checkout
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi
fi
