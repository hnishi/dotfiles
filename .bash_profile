#set -xv

echo reading .bash_profile

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

