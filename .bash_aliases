platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='freebsd'
fi

# echo your platform is $platform

if [[ $platform == 'linux' ]]; then
   alias ls='ls --color=auto'
elif [[ $platform == 'freebsd' ]]; then
   alias ls='ls -G'
fi

# confirmation
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
# enable color support of ls and also add handy aliases
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# Add an "alert" alias for long running commands.  Use like so:
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vi=vim
alias dirs="dirs -v"

# https://twitter.com/RitzmannMarkus/status/1308732440974962688
function cheat() { 
  curl https://cheat.sh/"$1" 
}

# docker
# 全コンテナ停止: docker stop $(docker ps -q)
alias docker_stop_all="docker stop $(docker ps -q)"
# 全コンテナ削除: docker rm $(docker ps -q -a)
alias docker_rm_all="docker rm $(docker ps -q -a)"
# 全イメージ削除: docker rmi $(docker images -q)
alias docker_rmi_all="docker rmi $(docker images -q)"
# docker image prune -a --force --filter "until=2021-05-01T00:00:00"
