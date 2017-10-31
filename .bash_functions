#!/bin/bash

function pull {
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
  if [ $branch == "master" ] ; then
    git branch --merged | grep -v '*' | xargs git branch -d
  else
    >&2 echo "Tried to use rmlocalbranches not on master. This will delete master branch. Abort."
  fi

}

_complete_ssh_hosts () {
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        comp_ssh_hosts=`cat ~/.ssh/known_hosts | \
                        cut -f 1 -d ' ' | \
                        sed -e s/,.*//g | \
                        grep -v ^# | \
                        uniq | \
                        grep -v "\[" ;
        cat ~/.ssh/config | \
                        grep "^Host " | \
                        awk '{print $2}'
                `
        COMPREPLY=( $(compgen -W "${comp_ssh_hosts}" -- $cur))
        return 0
}
complete -F _complete_ssh_hosts ssh

complete -W "\`grep -oE '^[a-zA-Z0-9_-]+:([^=]|$)' Makefile | sed 's/[^a-zA-Z0-9_-]*$//'\`" make

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
  dow=$(curl -s http://www.chiang-mai.ch/take-away-montag/ | grep -B1 "Sat&egrave; Gai" | grep Tagesmen | awk -F'&uuml' '{print $2}' | cut -c5- | awk -F'<' '{print $1}' | sed -e 's/\&.*//' ) 
  [[ ${dow} == $(LC_ALL=de_DE date +%A) ]] && echo "Today is Satè Gay day! :)" || echo "No Satè Gai today :( It's on ${dow}"
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

