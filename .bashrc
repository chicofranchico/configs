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

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# mac only
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  # (coreutils)
  test -e ~/.dircolors && eval `dircolors -b ~/.dircolors`
  alias ls="ls --color=auto"
fi
# end mac only

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

# git autocompletion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#######################################
# User specific aliases and functions #
#######################################

source ~/.bash-powerline.sh


# ssh agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
# ssh-add -K /path/to/key
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

