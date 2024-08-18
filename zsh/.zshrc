# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Powerlevel10k transient prompt
POWERLEVEL9K_TRANSIENT_PROMPT=always

# Replace cd with z from zoxide
eval "$(zoxide init zsh)"
alias cd='z'

# Replace ls with eza
alias ls='eza'

# Set colors for ls (LS_COLORS)
export LS_COLORS="$(vivid generate tokyonight-night)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Enable forgit (note that it introduces a bunch of aliases)
[ -f $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh ] && source $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh

# zsh plugins (without oh-my-zsh)
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Enable powerlevel10k (without oh-my-zsh)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Connect to UMCU vpn
alias vpn="$HOME/roodnoot/umcu_vpn.sh"

# Set bat theme
export BAT_THEME="Nord"

# Disable automatic use of less with bat
alias bat='bat --pager=never'

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

# Transient prompt
POWERLEVEL9K_TRANSIENT_PROMPT=always

# Quickly "j"ump to commonly used directory using zi from zoxide
bindkey -s 'j' 'zi\n'
