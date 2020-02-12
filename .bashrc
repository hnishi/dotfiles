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

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

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
  fi
fi

# completion
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

#if [ -f /path/to/git-completion.bash ]; then
#    source /path/to/git-completion.bash
#fi
#if [ -f /path/to/git-prompt.sh ]; then
#    source /path/to/git-prompt.sh
#fi

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

# source

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

export PS1='\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] [${?}]\n\$ '

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

echo your platform is $platform

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
  eval "$(pyenv init -)"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

