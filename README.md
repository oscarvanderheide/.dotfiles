See https://github.com/driesvints/dotfiles for a detailed overview of setting up and working with dotfiles.


## My own notes on initializing a new macOS machine

- Download Xcode Command Line Tools from https://developer.apple.com/download/ and install. No need to install Xcode (using App Store) itself.
- Generate ssh key-pair following instructions on Github (https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- Log into Github and add new ssh key.
- Clone .dotfiles to ~/.dotfiles
- Review files:
	- Brewfile (which software to install)
	- .macos (macOS system settings)
	- Install.sh (the actual script that gets executed)
- Run install.sh
- Make symlinks with stow: execute `stow .` from `~/.dotfiles`

	