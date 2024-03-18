#!/bin/bash
#

sudo sh -c 'echo "vscode ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode'
sudo chown -R vscode:vscode /home/vscode/
sudo chown -R vscode:vscode /dc


wget https://github.com/lsd-rs/lsd/releases/download/v1.0.0/lsd_1.0.0_`dpkg-architecture -q DEB_BUILD_ARCH`.deb -O /tmp/lsd.deb
sudo apt-get install /tmp/lsd.deb
rm -rf /tmp/lsd.deb

curl -s https://ohmyposh.dev/install.sh | sudo bash -s
oh-my-posh font install Meslo

if ! [ -d ~/.oh-my-posh/themes/ ]; then
  mkdir -p ~/.oh-my-posh/themes
fi
wget https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/powerlevel10k.omp.json -O ~/.oh-my-posh/themes/powerlevel10k.omp.json
echo 'eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/powerlevel10k.omp.json)"' >> ~/.zshrc
conda init --all
wget https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -O ~/.oh-my-zsh/custom/az.zsh

if ! [ -d ~/.vim/pack/plugin/start ]; then
  mkdir -p ~/.vim/pack/plugin/start
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-airline ]; then
  git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/plugin/start/vim-airline
else
  cd ~/.vim/pack/plugin/start/vim-airline || return
  git pull
fi

if ! [ -d ~/.vim/pack/plugin/start/vim-terraform ]; then
  git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugin/start/vim-terraform
else
  cd ~/.vim/pack/plugin/start/vim-terraform
  git pull
fi

if ! [ -d ~/.vim/pack/themes/start ]; then
  mkdir -p ~/.vim/pack/themes/start
fi

if ! [ -d ~/.vim/pack/themes/start/vim-code-dark ]; then
  git clone https://github.com/tomasiser/vim-code-dark ~/.vim/pack/themes/start/vim-code-dark
else
  cd ~/.vim/pack/themes/start/vim-code-dark || return
  git pull
fi

wget https://raw.githubusercontent.com/robinmordasiewicz/dotfiles/main/.vimrc -O ~/.vimrc

if ! [ -f mkdocs.yml ]; then
  cp .devcontainer/mkdocs.template mkdocs.yml
fi

FIRSTNAMELASTNAME=`git config --get user.name`
GITHUBREPOSITORYURL=`git config --get remote.origin.url`
GITHUBREPOSITORYCANONICALURL="${GITHUBREPOSITORYURL%.git}"
GITHUBUSERNAME=$(echo "$GITHUBREPOSITORYURL" | sed 's/.*github.com\/\([^\/]*\)\/.*/\1/')
GITHUBREPOSITORYNAME=$(echo "$GITHUBREPOSITORYURL" | sed 's/.*github.com\/[^\/]*\/\([^\/]*\)\.git/\1/')
GITHUBPAGESURL="https://$GITHUBUSERNAME.github.io/$GITHUBREPOSITORYNAME/"
GITHUBREPOSITORYAPIURL="https://api.github.com/repos/$GITHUBUSERNAME/$GITHUBREPOSITORYNAME"
GITHUBREPOSITORYDESCRIPTION=$(curl -s "$GITHUBREPOSITORYAPIURL" | jq -r '.description')
sed -i "s,GITHUBUSERNAME,${GITHUBUSERNAME},g" "mkdocs.yml"
sed -i "s,FIRSTNAMELASTNAME,${FIRSTNAMELASTNAME},g" "mkdocs.yml"
sed -i "s,GITHUBREPOSITORYNAME,${GITHUBREPOSITORYNAME},g" "mkdocs.yml"
sed -i "s,GITHUBREPOSITORYCANONICALURL,${GITHUBREPOSITORYCANONICALURL},g" "mkdocs.yml"
sed -i "s,GITHUBREPOSITORYDESCRIPTION,${GITHUBREPOSITORYDESCRIPTION},g" "mkdocs.yml"
sed -i "s,GITHUBPAGESURL,${GITHUBPAGESURL},g" "mkdocs.yml"

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
rm lazygit.tar.gz
sudo install lazygit /usr/local/bin
rm lazygit

pre-commit install --allow-missing-config

sudo -H env PATH=$PATH npm install -g npm@latest
sudo env PATH=$PATH npm install -g opencommit
echo "OCO_AI_PROVIDER=ollama" > ~/.opencommit
sudo -H env PATH="${PATH}" oco hook set


if command -v az &> /dev/null; then
    yes y | az config set auto-upgrade.enable=yes
    yes y | az config set auto-upgrade.prompt=no
fi

sudo apt update
sudo apt-get -y upgrade
sudo apt -y autoremove

yes y | conda update -n base -c defaults conda
yes y | conda update --all
yes y | conda update -n base -c defaults conda --repodata-fn=repodata.json

source /opt/conda/etc/profile.d/conda.sh

conda env create -f ./docs/mkdocs-environment.yml
