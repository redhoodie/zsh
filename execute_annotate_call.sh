alias an='execute_annotate_call'
execute_annotate_call() {
  if [ -f ./Gemfile ]
    then
      bundle exec annotate -p before --exclude tests,fixtures,specs
    else
      annotate -p before --exclude tests,fixtures,specs
  fi
}
