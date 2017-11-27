DEFAULT_USER=chicofranchico

# Path to your oh-my-zsh installation.
export ZSH=/Users/chicofranchico/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"


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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man colorize github jira vagrant virtualenv pip python brew osx zsh-syntax-highlighting)

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

# ansible
export ANSIBLE_REMOTE_USER="fdefreitas"
export ANSIBLE_PROJECT_PATH=/Volumes/teralytics/teralytics/teralytics-ops/ansible/

# direnv
eval "$(direnv hook zsh)"

# ssh agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add -K ~/.ssh/teralytics_rsa
unset SSH_ASKPASS

gpg-agent --daemon 2>&1 | grep -q "already running" || echo "GPG agent loaded."

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# brew paths
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# GO PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

