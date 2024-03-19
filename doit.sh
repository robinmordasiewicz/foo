#!/bin/bash
#

git remote add -f devcontainer https://github.com/robinmordasiewicz/devcontainer.git

git merge -s ours --no-commit --allow-unrelated-histories devcontainer/main

git read-tree --prefix=.devcontainer/ -u devcontainer/main:.devcontainer

git subtree pull --prefix .devcontainer https://github.com/robinmordasiewicz/devcontainer.git main

exit

git fetch devcontainer
git checkout -b devcontainer devcontainer/main
git checkout main
git read-tree --prefix=.devcontainer -u devcontainer:.devcontainer

