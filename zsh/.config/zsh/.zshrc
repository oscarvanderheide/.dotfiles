# Set location of .zshrc (note that I create an alias in ~ to this file to make it easier to edit)
export ZDOTDIR=$HOME/.config/zsh

# Load custom zsh files from .config/zsh
source $HOME/.config/zsh/zsh-functions
source $HOME/.config/zsh/zsh-exports
source $HOME/.config/zsh/zsh-aliases

# Some useful options
setopt auto_cd 				# Automatically cd into a directory if the command is a directory
setopt extended_glob 	# Enable extended globbing
setopt nomatch 				# If a glob does not match, return the glob itself
# setopt menucomplete

# Enable plugins (auto-installs if missing)
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "wfxr/forgit"
zsh_add_plugin "Aloxaf/fzf-tab"

# Setup of zoxide (cd replacement)
eval "$(zoxide init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Enable starship prompt
eval "$(starship init zsh)"

#autolist=yes        # Automatically lists options when ambiguous
#zstyle ':completion:*' menu select   # Allows you to cycle through options with arrow keys

# needed for fzf-tab
autoload -U compinit; compinit

# Keybindings for being able to use both auto-complete and auto-suggestions 
# bindkey '^I'   complete-word       # tab          | complete

# Strange issue with git config file
unset GIT_CONFIG

# Use TAB to cycle rather than select the first option
# bindkey '^I' menu-complete

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept --height 40%
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Set custom location for .tmux.conf
# alias tmux='tmux -f ~/.config/tmux/.tmux.conf'

# Quick jump to most used directories (using zi)
bindkey -s 'jj' 'zi\n' # Jump to most used directories
bindkey -s 'kk' 'ls\n' # List files in current directory
bindkey -s 'yy' 'yazi_cd\n' # Open yazi and change dir upon exit
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
