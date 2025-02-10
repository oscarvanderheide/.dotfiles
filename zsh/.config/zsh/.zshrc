# Set location of .zshrc (note that I create an alias in ~ to this file to make it easier to edit)
export ZDOTDIR=$HOME/.config/zsh

# Settings for command history
HISTFILE=$HOME/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt SHARE_HISTORY           # Share history between terminal sessions
setopt HIST_IGNORE_ALL_DUPS    # Ignore duplicate commands in history
setopt HIST_SAVE_NO_DUPS       # Don't save duplicates to the history file
setopt INC_APPEND_HISTORY      # Immediately append commands to the history file
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands

# Load custom zsh files from .config/zsh
source $HOME/.config/zsh/zsh-functions
source $HOME/.config/zsh/zsh-exports
source $HOME/.config/zsh/zsh-aliases
source $HOME/.config/zsh/zsh-keybinds
source $HOME/.config/zsh/zsh-completions

# Some useful options
setopt no_beep
setopt auto_cd 				# Automatically cd into a directory if the command is a directory

# Enable plugins (auto-installs if missing)
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "wfxr/forgit"
# zsh_add_plugin "Aloxaf/fzf-tab"

# Enable zoxide (cd replacement)
eval "$(zoxide init zsh)"

# Enable fzf (fuzzy finder)
source <(fzf --zsh)

# Enable starship prompt
eval "$(starship init zsh)"

# needed for fzf-tab
ZCOMPDUMP=$HOME/.zcompdump
ZCOMPCACHE=$HOME/.zcompcache
autoload -U compinit; compinit

# Keybindings for being able to use both auto-complete and auto-suggestions 

# bindkey '^I'   complete-word       # tab          | complete
# Strange issue with git config file
unset GIT_CONFIG

# Use TAB to cycle rather than select the first option
# bindkey '^I' menu-complete

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/oscar/.lmstudio/bin"
