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

