#!/usr/bin/env bash

# display files beginning with a dot in finder
defaults write com.apple.finder AppleShowAllFiles YES

echo "Finder: show hidden files"

killall Finder
