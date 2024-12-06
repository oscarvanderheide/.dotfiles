# Replace vim with nvim
alias vim='nvim'
alias v='nvim'

# Replace cd with z from zoxide
eval "$(zoxide init zsh)"
alias cd='z'

# Quick jump to most used directories (using zi)
bindkey -s 'jj' 'zi\n'

# Replace ls with eza
alias ls='eza'
alias l='ls' 
alias lt2='ls --tree --level=2'
alias lt3='ls --tree --level=3'

# Set colors for ls (LS_COLORS)
export LS_COLORS="$(vivid generate iceberg-dark)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Enable fzf-git keybindings
source $HOME/.config/zsh/fzf-git.sh

#autolist=yes        # Automatically lists options when ambiguous
#zstyle ':completion:*' menu select   # Allows you to cycle through options with arrow keys

# needed for fzf-tab
autoload -U compinit; compinit

# Enable forgit (note that it introduces a bunch of aliases)
[ -f $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh ] && source $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh

# zsh plugins (without oh-my-zsh)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Connect to UMCU vpn
alias vpn="$HOME/roodnoot/umcu_vpn.sh"

# Replace cat with bat (disable automatic use of less with bat)
alias cat='bat  --pager=never'

# Set bat theme
export BAT_THEME="Nord"

# Use ripgrep config file
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Enable custom zsh functions defined in separete file
source $HOME/.config/zsh/zsh_functions

# Custom location for .gitconfig
export GIT_CONFIG=~/.config/git/.gitconfig 

# Convenient aliases
source $HOME/.config/zsh/zsh_aliases

# Keybindings for being able to use both auto-complete and auto-suggestions 
# bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# Define the fda function for interactive directory selection
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && z "$dir"
}

# Strange issue with git config file
unset GIT_CONFIG

# Display options for fzf
# export FORGIT_FZF_DEFAULT_OPTS=" --exact --border --cycle --reverse --height '30%' "
# export FZF_DEFAULT_COMMAND="fd --type f"

# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_DEFAULT_OPTS='--layout=reverse --border'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"


# Use TAB to cycle rather than select the first option
# bindkey '^I' menu-complete


# Interactive find-in-files 
fif() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

# yazi shortcut and change directory upon exit
function yazi_cd() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

bindkey -s yy 'yazi_cd\n'
# Show system info on start of new shell
# fastfetch

# Enable fzf-based tab completion
source $HOME/.config/zsh/fzf-tab/fzf-tab.plugin.zsh

# # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # set descriptions format to enable group support
# # NOTE: don't use escape sequences here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# # set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ':completion:*' menu no
# # preview directory's content with eza when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# # switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'
# # tmux style popup
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:*' fzf-flags '--height=50% --layout=reverse'
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
alias tmux='tmux -f ~/.config/tmux/.tmux.conf'

# Use python installed with homebrew
export PATH="/opt/homebrew/opt/python@3.10/libexec/bin:$PATH"

# Add location with custom scripts to path
export PATH="$HOME/.local/bin::$PATH"

# Node.js (needed for Github Copilot in nvim)
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# Enable starship prompt
eval "$(starship init zsh)"

source /Users/oscar/.config/broot/launcher/bash/br
