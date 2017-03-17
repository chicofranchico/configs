function pull {
  if [ ! -z "$1" ]; then
    git pull origin "$1"
  else
    branch=$(git branch | grep '*' | cut -d'*' -f2 | tr -d ' ')
    git pull origin master
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

_complete_ssh_hosts ()
{
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

function ssh_no_ask_pass () {

  if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
  ssh-add -l | grep "The agent has no identities" && ssh-add $1
  unset SSH_ASKPASS

}

function rspec_this {
  export PUPPET_VERSION=3.8.7
  export STRINGIFY_FACTS=no
  export TRUSTED_NODE_DATA=yes
  bundle --without development
  bundle exec rake
  export FUTURE_PARSER=yes
  bundle exec rake
}

