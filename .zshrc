DEFAULT_USER=chicofranchico

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=/Users/chicofranchico/.oh-my-zsh
export ZSH_THEME="powerlevel9k/powerlevel9k"

setopt extended_glob

HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
#shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE
HISTTIMEFORMAT="%d/%m/%y %T "

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

export KUBE_PS1_SYMBOL_USE_IMG=true

prompt_kube_ps1(){
   echo -n `kube_ps1`
}

#zsh_custom_kube_ps1(){
#  echo -n "$(_kube_ps1_symbol)$KUBE_PS1_SEPERATOR$KUBE_PS1_CONTEXT$KUBE_PS1_DIVIDER$KUBE_PS1_NAMESPACE"
#}

#export POWERLEVEL9K_CUSTOM_KUBE_PS1='zsh_custom_kube_ps1'

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(colorize virtualenv pip python brew osx kube-ps1)

export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv aws kube_ps1)

export POWERLEVEL9K_PROMPT_ON_NEWLINE=true
export POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

export POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
export POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=' $ '

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

fortune

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# mac only
if [[ "$OSTYPE" == "darwin"* ]]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
  # (coreutils)
  test -e ~/.dircolors && eval `dircolors -b ~/.dircolors`
  alias ls="ls --color=auto"
fi
# end mac only

# Function defs
if [ -f ~/.bash_functions ]; then
  . ~/.bash_functions
fi

# Function defs
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# ansible
export ANSIBLE_REMOTE_USER="<your_user>"

export ANSIBLE_STRATEGY_PLUGINS=~/mitogen/ansible_mitogen/plugins/strategy
export ANSIBLE_STRATEGY=mitogen_linear

# direnv
eval "$(direnv hook zsh)"

# ssh agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add -K ~/.ssh/id_rsa
unset SSH_ASKPASS

#echo "pinentry-program /usr/local/bin/pinentry-mac" >> ~/.gnupg/gpg-agent.conf
#gpg-agent --daemon 2>&1 | grep -q "already running" || echo "GPG agent loaded."

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# brew paths
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# GO PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin:~/go/bin

source /usr/local/bin/virtualenvwrapper.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

kubeoff

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

# make sure gcloud uses the system's python (newer python versions don't work properly)
export CLOUDSDK_PYTHON="/usr/bin/python"

source <(stern --completion=zsh)

