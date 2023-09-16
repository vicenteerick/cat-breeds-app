#!/bin/sh

# Install Homebrew dependencies
installHomebrew='/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

which -s brew
if [[ $? != 0 ]] ; then
  echo "Installing Homebrew..."
  eval $installHomebrew
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/ctdev/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "Homebrew installed."
fi