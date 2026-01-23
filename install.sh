#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add to path
  echo >> /Users/$USER/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
# brew tap homebrew/bundle
brew bundle

# Not sure if I want to keep using Mackup
# Symlink the Mackup config file to the home directory
# ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos

# Set git options (from https://spin.atomicobject.com/2020/05/05/git-configurations-default/)
git config --global user.name "oscar"
git config --global user.email "oscarvanderheide@gmail.com"
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra	
git config --global core.excludesfile ~/.config/git/.gitignore_global

# Install juliaup using defaults 
curl -fsSL https://install.julialang.org | sh -s -- --yes

# Use stow to symlink dotfiles
stow -v -t ~ bat
stow -v -t ~ git
stow -v -t ~ kmonad
stow -v -t ~ nvim
stow -v -t ~ ripgrep
stow -v -t ~ tmux
stow -v -t ~ wezterm
stow -v -t ~ yazi
stow -v -t ~ zsh

# Make symbolic link in home to the .zshrc file 
ln -s /Users/$USER/.config/zsh/.zshrc .zshrc 

# Clone zsh plugins
echo "Installing zsh plugins..."
mkdir -p $HOME/.config/zsh/plugins
git clone https://github.com/wfxr/forgit.git $HOME/.config/zsh/plugins/forgit
git clone https://github.com/Aloxaf/fzf-tab.git $HOME/.config/zsh/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.config/zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/zsh/plugins/zsh-syntax-highlighting

# Make symbolic links for vscode settings and keybindings
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Need to check where vscode user files are stored"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Delete existing json files
    rm /Users/$USER/Library/Application\ Support/Code/User/settings.json
    rm /Users/$USER/Library/Application\ Support/Code/User/keybindings.json
    # Make symbolic links to the ones in .dotfiles
    ln -s settings.json /Users/$USER/Library/Application\ Support/Code/User/settings.json
    ln -s keybindings.json /Users/$USER/Library/Application\ Support/Code/User/keybindings.json
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    echo "Unsupported OS"
else
    echo "Unsupported OS"
fi
# Manually install the following tools
# Dropover

# Add yazi plugins
ya pkg add yazi-rs/plugins:git
ya pkg add yazi-rs/plugins:full-border
ya pkg add yazi-rs/plugins:smart-paste
ya pkg add yazi-rs/plugins:jump-to-char
ya pkg add yazi-rs/plugins:toggle-pane
ya pkg add yazi-rs/plugins:no-status
ya pkg add AnirudhG07/custom-shell
ya pkg add yazi-rs/plugins:smart-enter


# Set nvim to nightly with bob
bob use nightly
