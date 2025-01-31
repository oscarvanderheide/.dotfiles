# Set location of .zshrc (note that I create an alias in ~ to this file to make it easier to edit)
export ZDOTDIR=$HOME/.config/zsh

# Settings for command history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
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

# Some useful options
setopt no_beep
setopt auto_cd 				# Automatically cd into a directory if the command is a directory
setopt extended_glob 	# Enable extended globbing
# setopt menucomplete

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

# # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # set descriptions format to enable group support
# # NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# # set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# # zstyle ':completion:*' menu no
# # preview directory's content with eza when completing cd
# # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# # custom fzf flags
# # NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
# # zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept --height 40%
# # To make fzf-tab follow FZF_DEFAULT_OPTS.
# # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# # zstyle ':fzf-tab:*' use-fzf-default-opts yes
# # switch group using `<` and `>`
# # zstyle ':fzf-tab:*' switch-group '<' '>'
# zstyle ':completion:*:*:cd:*' tag-order local-directories
# zstyle ':completion:*:cd:*' ignored-patterns '.*'

zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' condition 0
zstyle ':completion:*' expand prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d ...'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-prompt '%SViewing %p: Keep TABBING to select or insert characters manually... %s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Found %e errors...'
zstyle ':completion:*' select-prompt '%SScrolling... currently at %p%s'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

