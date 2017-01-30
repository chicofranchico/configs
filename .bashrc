# .bashrc

# ~/.bashrc: executed by bash(1) for non-login shells.
export CLICOLOR=1

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE
HISTSIZE=1000000
HISTFILESIZE=2000000
HISTTIMEFORMAT="%d/%m/%y %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
test -e ~/.dircolors && \ 

# dircolors
eval `dircolors -b ~/.dircolors`
alias ls="ls --color=always" 
alias grep="grep --color=always"
alias egrep="egrep --color=always"

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Function defs
if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

# term bindings (mainly for tmux)
if [ -f ~/.readline-bindings ] ; then
  bind -f ~/.readline-bindings
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific aliases and functions

# ssh agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add
unset SSH_ASKPASS

# gpg agent
GPG_TTY=$(tty)
export GPG_TTY

if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
else
  gpg-agent 2>&1 | grep "no gpg-agent running" && eval `gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info"`
fi

