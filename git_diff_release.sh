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
    remote_release=$(git branch -r | grep "origin/releases/$environment")
    if [ -n "$remote_release" ]; then
      echo "\033[32m${(C)environment}\033[0m"

      deployed_branches=$(git --no-pager log -n 1 origin/releases/$environment --pretty=format:"%d" | tr -d ' ()' | sed -e 's/,/\
/g' | grep '^origin/' | grep -v '^origin/releases/' | sed -e 's/origin\//Branch: /g' | grep -v 'HEAD')
      clobbered_commits=$(git --no-pager log ..origin/releases/$environment --pretty=format:"%C(red)%an%x09%C(reset)%s")
      pending_commits=$(git --no-pager log origin/releases/$environment.. --pretty=format:"%C(yellow)%an%x09%C(reset)%s")

      if [ -n "$deployed_branches" ]; then
        echo "\033[32m$deployed_branches\033[0m"
      fi

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
      echo "Error: $environment release not tagged"
    fi
    echo ""
  done
}
