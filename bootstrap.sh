#!/usr/bin/env bash

# check if xcode is installed
if xcode-select -p 1>/dev/null; then
  echo "Xcode is installed"
else
  echo "Xcode was not found. Installing..."
  xcode-select --install
  sudo xcode-select --switch /Library/Developer/CommandLineTools
fi



# check current folder

DOTS_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTS_DIR

# if DOTS_DIR is not `$HOME/.dotfiles`, warn and exit
if [ "$DOTS_DIR" != "$HOME/.dotfiles" ]; then
	echo "Error: DOTS_DIR is not $HOME/.dotfiles" >&2
	exit 1
fi

# check if Homebrew is installed
if command -v brew 1>/dev/null; then
  echo "Homebrew is installed"
else
  echo "Homebrew was not found. Installing..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# generate github ssh key
if [ ! -f "$HOME/.ssh/github_rsa" ]; then
  ssh-keygen -t rsa -b 4096 -C "github" -f "$HOME/.ssh/github_rsa" -N ""
  echo "Add the following public key to github:"
  cat "$HOME/.ssh/github_rsa.pub"
  # set the public key to the clipboard
  pbcopy < "$HOME/.ssh/github_rsa.pub"

  
fi



# launch macos_config.sh
"$DOTS_DIR/macos_config.sh"

# launch brew.sh
"$DOTS_DIR/brew.sh"

# shell setup
"$DOTS_DIR/shell_setup.sh"







