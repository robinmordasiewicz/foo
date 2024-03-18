# devcontainer

## VSCode Plugin

https://code.visualstudio.com/docs/devcontainers/containers

## Fonts

For best results install Nerd fonts in VSCode:

* Mac brew tap homebrew/cask-fonts && brew install --cask font-meslo-lg-nerd-font

* Windows - Google it

1. Open VSCode Settings

2. Search for "terminal.integrated.fontFamily"

3. Type in "MesloLGS NF"

## mkdocs

http://127.0.0.1:8000

## Terraform

tfenv install latest

## Github CLI

gh auth login

## Ollama on Mac

https://nonsequiturs.com/posts/run-ollama-in-the-menu-bar-on-macos-with-custom-host-bindings/?s=%23YOUREWELCOME

* Open Script Editor and paste the following text

```
do shell script "launchctl setenv OLLAMA_ORIGINS '*'"
do shell script "launchctl setenv OLLAMA_HOST \"0.0.0.0\""
tell application "Ollama" to run
```

* export the script as an Application

* add the appliation to login items

## Troubleshooting docker

docker system prune -a -f
