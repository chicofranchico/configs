#!/bin/bash

function pull {
  git fe -p
  if [ ! -z "$1" ]; then
    git pull origin "$1"
  else
    branch=$(git branch | grep '*' | cut -d'*' -f2 | tr -d ' ')
    git pull origin $branch
  fi
}

function push {
  if [ ! -z "$1" ]; then
    git push origin "$1"
  else
    branch=$(git branch | grep '*' | cut -d'*' -f2 | tr -d ' ')
    git push origin $branch
  fi
}

function rmlocalbranches {
  branch=$(git branch | grep '*' | cut -d'*' -f2 | tr -d ' ')
  if [ $branch = "master" ] ; then
    git branch --merged | grep -v '*' | xargs git branch -d
  else
    >&2 echo "Tried to use rmlocalbranches not on master. This will delete master branch. Abort."
  fi

}

function ssh_no_ask_pass () {
  if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
  ssh-add -l | grep "The agent has no identities" && ssh-add $1
  unset SSH_ASKPASS

}

is_today_sate_gai () {
  dow=$(curl -s https://www.chiang-mai.ch/menu | grep -v -e '^[[:space:]]*$' | grep -B12 "Satè Gai" | grep "h1" | sed -e 's/<h1/|/g' | awk -F'|' '{print $2}' | sed -e 's/—/-/g' | cut -d'-' -f3 | awk '{print "\""$0"\""}' | cut -d'>' -f2 | tr -d ' ' | tr -d '"') 
  [[ ${dow} == $(LC_ALL=de_DE date +%A) ]] && echo "Today is Satè Gai day! :)" || echo "No Satè Gai today :( It's on ${dow}"
}

# following functions taken from here: https://github.com/Daenyth/dotfiles/blob/master/.bashrc

# shquot() -- Escape a filename properly {{{
shquot () {
    # http://plasmasturm.org/log/293/
    quoted=${0/\'/\'\\\'\'}
    # 'Github syntax highlighting breaks on the above line, heh. Quoted here to fix it
    echo "'$quoted'"
}
# }}}

# repeat() -- repeat a given command N times {{{
function repeat() {
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do
        eval "$@";
    done
}
# }}}

# ask() -- ask user a yes/no question {{{
function ask() {
    echo -n "$@" '[y/N] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}
# }}}

function myip() {
  echo "dig +short myip.opendns.com @resolver1.opendns.com"
  dig +short myip.opendns.com @resolver1.opendns.com
}

function dc_trace_cmd() {
  local parent=`docker inspect -f '{{ .Parent }}' $1` 2>/dev/null
  declare -i level=$2
  echo ${level}: `docker inspect -f '{{ .ContainerConfig.Cmd }}' $1 2>/dev/null`
  level=level+1
  if [ "${parent}" != "" ]; then
    echo ${level}: $parent
    dc_trace_cmd $parent $level
  fi
}
