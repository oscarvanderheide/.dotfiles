#!/bin/bash

current=$(tmux display-message -p "#S")
output=""

# Build a horizontal list:  [ACTIVE]  other  other
while read -r name; do
    if [[ "$name" == "$current" ]]; then
        # GREEN and BOLD for active
        output="${output}#[fg=green,bold] [${name}] #[default]"
    else
        # GREY for inactive
        output="${output}#[fg=colour240] ${name} #[default]"
    fi
done < <(tmux list-sessions -F "#{session_name}")

echo "$output"
