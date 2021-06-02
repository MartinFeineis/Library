#!/bin/bash

#branch=`echo $HOST | awk -F . '{print $1}'`
branch=`echo $(hostname) | awk -F . '{print $1}'`
#echo $branch " line 4"
existed_in_remote=$(git ls-remote --heads origin $branch)
#echo $existed_in_remote " existed_in_remote"
if [[ ! -z "$existed_in_remote" ]]; then
    git checkout $branch
    echo "checked out branch $branch"
else
    echo "try new branch"
    git checkout -b $branch
    git push --set-upstream origin $branch
fi

dots=( "zshrc" "bashrc" "vimrc" "tmux.conf" "config/terminator/config")

for file in ${dots[@]}; do
  name="$HOME/.$file"
  if [[ -f "$name" ]]; then
    #target=`echo $file | tr -d '.'`
    echo -e "syncing \033[0;33m$name \033[0m to \033[0;33m$file \033[0m"
    rsync $name $file
    git add $file
  else
    echo -e "file \033[0;35m $name \033[0m  does not exist, omitting"
  fi
done

echo "commiting with timestamp $(date +”%Y-%m-%dT%H:%M:%S”)"
git commit -m "$(date +”%Y-%m-%dT%H:%M:%S”)"
git push
