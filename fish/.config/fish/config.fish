if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable the fish greeting message
set fish_greeting ""
 
# Print a new line after any command
#source ~/.config/fish/functions/postexec_newline.fish
 
# Setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"
 
# Clear line on CTRL + C
# Sometimes it still doesn't work well enough on node.js scripts :(
bind --preset \cC 'cancel-commandline'

# `ls` → `ls -laG` abbreviation
# abbr -a -g ls ls -lG

# `ls` → `eza` abbreviation
# Requires `brew install eza`
#if type -q eza
#  abbr --add -g ls 'eza --long --classify --all --header --git --no-user --tree --level 1'
#end
alias ls='eza --icons always -l --group-directories-first --tree --level 1'
abbr --add -g ls 'eza --icons always -l --group-directories-first --tree --level 1'

# Key bindings for nextd and prevd
bind \e, 'prevd && commandline --function repaint'
bind \e. 'nextd && commandline --function repaint'

# Enable zoxide and use as replacement for cd
zoxide init fish | source
alias cd='z'

# Enable fzf bindings
fzf_configure_bindings --directory=\ct
source ~/.config/fish/themes/base16-nord.fish

# Enable forgit
[ -f $HOMEBREW_PREFIX/share/forgit/forgit.plugin.fish ]; and source $HOMEBREW_PREFIX/share/forgit/forgit.plugin.fish

# Set bat theme
export BAT_THEME="Nord"

# Use ripgrep config file
set -x RIPGREP_CONFIG_PATH /path/to/your/ripgrep/config
