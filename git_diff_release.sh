alias gdr=git_diff_release
git_diff_release() {
  git fetch

  environments=()
  if (( $# == 0 ))
  then
    environments=("${(@f)$(git branch -r | grep 'origin/releases/' | sed 's/origin\/releases\///g' | tr -d ' ')}")
  else
    for i
    do
      environments+=$i
    done
  fi

  for environment in $environments
  do
    echo "\033[32m${(C)environment}:\033[0m"
    remote_release=$(git branch -r | grep "origin/releases/$environment")
    if [ -n "$remote_release" ]; then
      clobbered_commits=$(git --no-pager log ..origin/releases/$environment --pretty=format:"%C(red)%an%x09%C(reset)%s")
      pending_commits=$(git --no-pager log origin/releases/$environment.. --pretty=format:"%C(yellow)%an%x09%C(reset)%s")

      if [ -n "$clobbered_commits" ]; then
        echo "\033[31mCommits about to be clobbered\033[0m"
        echo "$clobbered_commits"
      fi

      if [ -n "$pending_commits" ]; then
        echo "\033[33mPending commits\033[0m"
        echo "$pending_commits"
      else
        echo "There are no pending commits"
      fi
    else
      echo "$environment release not tagged"
    fi
    echo ""
  done
}
