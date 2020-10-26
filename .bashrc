# hnishi's .bashrc
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Show date and time in history
export HISTTIMEFORMAT='%F %T '

# https://twitter.com/nixcraft/status/1258027970406408192
#export HISTIGNORE='ls *:pwd'

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar &> /dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set environment varibales
export PATH=$HOME/.local/bin:$PATH

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f /etc/bash_completion.d/git-prompt ]; then
    . /etc/bash_completion.d/git-prompt
  fi
fi

# completion
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]]; then
  . "/usr/local/etc/profile.d/bash_completion.sh"
elif [[ -r "/etc/profile.d/bash_completion.sh" ]]; then
  . "/etc/profile.d/bash_completion.sh"
#else
#  echo "bash_completion.sh was not found (~/.bashrc)."
fi

#if [ -f /path/to/git-completion.bash ]; then
#    source /path/to/git-completion.bash
#fi
#if [ -f /path/to/git-prompt.sh ]; then
#    source /path/to/git-prompt.sh
#fi

# Since MacOS Catalina (version 10.15), the followings are not available.
# Thus, I hold the scripts in this repository.
# The scripts are from https://github.com/git/git/tree/master/contrib/completion
# git completion
source ~/.git-completion.bash
# git prompt
source ~/.git-prompt.sh

#--------------------------------------------------------------#

##          Environment Variables                             ##
#--------------------------------------------------------------#

# TODO: Separate settings of environmet variables from .bashrc into a different file.
#       like https://github.com/yutakatay/dotfiles/blob/80a0dfe3a63986550a51aa8dbb4d74746ae51a62/.zshenv

# TODO: Create .dotlibs in my .dotfiles to implement the function to color exit status in PS!
#       like https://github.com/yutakatay/dotfiles/blob/4f6f75c7ca4584500a1526954505372843a60ef1/.zsh/rc/prompt.zsh#L37

export DOTLIBS_DIR=$HOME/.dotlibs

#--------------------------------------------------------------#
##          Prompt Configuration                              ##
#--------------------------------------------------------------#

# add されていない変更の存在を「＊」で示す
# commit されていない変更の存在を「＋」で示す
GIT_PS1_SHOWDIRTYSTATE=true
# add されていない新規ファイルの存在を「％」で示す
GIT_PS1_SHOWUNTRACKEDFILES=true
# stash がある場合は「＄」で示す
GIT_PS1_SHOWSTASHSTATE=true
# upstream と同期している場合は「＝」で示す
# upstream より進んでいる場合は「＞」で示す
# upstream より遅れている場合は「＜」で示す
GIT_PS1_SHOWUPSTREAM=auto

# Color definitions
WHITE="\[\e[0m\]"
YELLOW="\[\e[0;33m\]"
DARK_GREEN="\[\e[0;32m\]"
GREEN="\[\e[1;32m\]"
CYAN="\[\e[0;36m\]"
PALE_BLUE="\[\e[1;34m\]"
RED="\[\e[0;31m\]"
PALE_RED="\[\e[1;31m\]"
MAGENTA="\[\e[0;35m\]"

PS1_USER="\u@\h"

# source ${DOTLIBS_DIR}/utils.bash

# to show date and time in PS1
function get_datetime {
  prompt_datetime=$(date +%Y%m%d-%H:%M:%S)
}

# Show wall time of the last commands in PS1
# https://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt
function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

# add info of virtual env in prompt
# https://stackoverflow.com/a/20026992
function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "(venv:$venv) "
}

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1

# ディスパッチ処理
# https://qiita.com/tay07212/items/9509aef6dc3bffa7dd0c
dispatch () {
  local EXIT_STATUS="$?" # 直前のコマンド実行結果のエラーコードを保存
  #export EXIT_STATUS="$?" # 直前のコマンド実行結果のエラーコードを保存

  local f
  for f in ${!PROMPT_COMMAND_*}; do #${!HOGE*}は、HOGEで始まる変数の一覧を得る
      eval "${!f}" # "${!f}"は、$fに格納された文字列を名前とする変数を参照する（間接参照）
  done
  unset f

  timer_stop
  get_datetime

  # https://shuheikagawa.com/blog/2015/10/18/color-prompt-by-exit-code/
  local status_color=""
  if [ $EXIT_STATUS != 0 ]; then
    status_color=$PALE_RED
  else
    status_color=$DARK_GREEN
  fi

  VENV="\$(virtualenv_info)";

  #export PS1="$PS1_USER$PALE_BLUE\w$PALE_RED $(__git_ps1) $DARK_GREEN ${status_color} [exit: \$?] $CYAN[last: \${timer_show}s] $WHITE[\${prompt_datetime}]\n\$ "
  export PS1="${MAGENTA}${VENV}${GREEN}${PS1_USER}${WHITE}:${PALE_BLUE}\w${CYAN}$(__git_ps1) ${status_color} [exit: \$?] ${WHITE}[last: ${timer_show}s] [${prompt_datetime}]\n\$ "
}

export PROMPT_COMMAND=dispatch

# Load OS-specific settings
# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
#if [[ "$OSTYPE" == "linux-gnu" ]]; then
#        # ...
#elif [[ "$OSTYPE" == "darwin"* ]]; then
#        # Mac OSX
#  source "${HOME}/.bashrc_mac"
#elif [[ "$OSTYPE" == "cygwin" ]]; then
#        # POSIX compatibility layer and Linux environment emulation for Windows
#elif [[ "$OSTYPE" == "msys" ]]; then
#        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
#elif [[ "$OSTYPE" == "win32" ]]; then
#        # I'm not sure this can happen.
#elif [[ "$OSTYPE" == "freebsd"* ]]; then
#        # ...
#else
#        # Unknown.
#fi

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

if [[ $platform == 'linux' ]]; then
  source "${HOME}/.bashrc_linux"
elif [[ $platform == 'freebsd' ]]; then
  source "${HOME}/.bashrc_mac"
fi

# 個々の環境のbash設定を読み込む
if [ -e "${HOME}/.bashrc_local" ]; then
  source "${HOME}/.bashrc_local"
fi

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  #pyenv init - &> /dev/null
  eval "$(pyenv init -)" &> /dev/null
fi

if command -v pipenv 1>/dev/null 2>&1; then
  eval "$(pipenv --completion)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export LANG=ja_JP.UTF-8

