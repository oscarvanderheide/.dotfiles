# Shortcuts
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"
weather() { curl -4 wttr.in/${1:-amsterdam} }
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

# Directories
alias dotfiles="cd $DOTFILES"

# # Git
# alias commit="git add . && git commit -m"
# alias gcommit="git add . && git commit"
# alias amend="git commit --amend --no-edit"
# alias amendall="git add . && amend"
# alias wip="commit wip"
# alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
# alias gd="git diff"
# alias resolve="git add . && git commit --no-edit"
# alias gl="git log --oneline --decorate --color"
# alias nuke="git clean -df && git reset --hard"
alias l="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"