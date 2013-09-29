# redhoodie's zshrc for [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

First, install oh-my-zsh

$ `curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`

Then, clone this repo

$ `git clone https://github.com/redhoodie/zsh.git ~/.zsh`

$ `ln -s ~/.zsh/zshrc ~/.zshrc`

Note: If you just want to include an individual file, source it in your .zshrc like so

```zsh
source ~/.zsh/execute_annotate_call.sh
source ~/.zsh/git_delete_merged_branches.sh
source ~/.zsh/git_diff_release.sh
```
