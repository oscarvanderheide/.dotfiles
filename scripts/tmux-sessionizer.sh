#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
selected=$( 
    {
        # 0. Show existing tmux sessions first
        if pgrep tmux >/dev/null 2>&1; then
            # echo "===EXISTING SESSIONS==="
            tmux list-sessions -F "#{session_name}" 2>/dev/null
        fi

        # 1. The Primeagen Strategy:
        # We look inside "$HOME/Projects/*" (which expands to work, personal, etc.)
        # We tell find to look exactly 1 level deep inside those.
        # This guarantees we get the repos, but NEVER the .git folders inside them.
        echo ""
        echo "===PROJECTS==="
        find "$HOME/Projects" -mindepth 1 -maxdepth 1 -type d 2>/dev/null
        # 2. Add your dotfiles manually (or any other standalone project)
        echo ""
        echo "===DOTFILES==="
        echo "$HOME/dotfiles"
    } | fzf \
        --reverse \
        # --header="Select Project" \
        --prompt="🔭 " \
        --delimiter="/" \
        --with-nth=-2..  # Shows "work/api" instead of full path

)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if [[ -z $TMUX ]]; then
    tmux attach -t $selected_name
else
    tmux switch-client -t $selected_name
fi
