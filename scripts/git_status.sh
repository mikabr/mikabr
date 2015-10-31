for repo in $( find /Users/mikabr/projects -name ".git" ); do
  cd $(dirname ${repo})
  status=$(git -c 'color.ui=always' status -s)
  if [[ $status ]]; then
    echo $(pwd)
    echo "$status"
    echo
  fi
done
