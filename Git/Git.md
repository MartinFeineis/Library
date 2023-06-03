# Git Stuff

## Rewriting history
Checkout the commit you want keep, if you want to wipe everythin checkout the
initial commit. Then reset the HEAD to this commit and force push it. 
```
git checkout 1a2b3c
git reset --hard origin/master
git commit -am "rewriting history"
git push --force origin HEAD:master
```
