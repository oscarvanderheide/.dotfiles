# Set location of .zshrc (note that I create an alias in ~ to this file to make it easier to edit)
export ZDOTDIR=$HOME/.config/zsh

# Needed for new tmux tabs through cmd + t
if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Settings for command history
HISTFILE=$HOME/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt SHARE_HISTORY           # Share history between terminal sessions
setopt HIST_IGNORE_ALL_DUPS    # Ignore duplicate commands in history
setopt HIST_SAVE_NO_DUPS       # Don't save duplicates to the history file
setopt INC_APPEND_HISTORY      # Immediately append commands to the history file
setopt HIST_REDUCE_BLANKS      # Remove extra blanks from commands

# For completion engine (including fzf-tab)
autoload -U compinit; compinit

# Load custom zsh files from .config/zsh
source $HOME/.config/zsh/zsh-functions
source $HOME/.config/zsh/zsh-exports
source $HOME/.config/zsh/zsh-aliases
source $HOME/.config/zsh/zsh-keybinds
# source $HOME/.config/zsh/zsh-completions

# Some useful options
setopt no_beep
setopt auto_cd 				# Automatically cd into a directory if the command is a directory

# Enable plugins (auto-installs if missing)
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "wfxr/forgit"
zsh_add_plugin "Aloxaf/fzf-tab"

# Enable zoxide (cd replacement)
eval "$(zoxide init zsh)"

# Enable fzf (fuzzy finder)
source <(fzf --zsh)

# Enable starship prompt
eval "$(starship init zsh)"

# source ~/somewhere/fzf-tab.plugin.zsh

# needed for fzf-tab
ZCOMPDUMP=$HOME/.zcompdump
ZCOMPCACHE=$HOME/.zcompcache
# autoload -U compinit; compinit

# Keybindings for being able to use both auto-complete and auto-suggestions 

# bindkey '^I'   complete-word       # tab          | complete
# Strange issue with git config file
unset GIT_CONFIG

# Use TAB to cycle rather than select the first option
# bindkey '^I' menu-complete

# autoload -U add-zsh-hook
#
# activate_venv() {
#     if [ -f "./.venv/bin/activate" ]; then
#         source "./.venv/bin/activate"
#     elif [ -f "./venv/bin/activate" ]; then
#         source "./venv/bin/activate"
#     fi
# }
#
# add-zsh-hook chpwd activate_venv
# activate_venv 

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
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


