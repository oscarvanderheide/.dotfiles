#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Not sure if I want to keep using Mackup
# Symlink the Mackup config file to the home directory
# ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos

# Set git options (from https://spin.atomicobject.com/2020/05/05/git-configurations-default/)
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra	
git config --global core.excludesfile ~/.config/git/.gitignore_global

# Use stow to symlink dotfiles
stow -v -t ~ fish
stow -v -t ~ git
stow -v -t ~ wezterm
stow -v -t ~ tmux
stow -v -t ~ bat
stow -v -t ~ nvim
stow -v -t ~ zsh


# Manually install the following tools
# Dropover
