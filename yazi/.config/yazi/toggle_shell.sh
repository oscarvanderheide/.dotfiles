    
#!/bin/bash


PANE_TITLE="Yazi Shell"
PANE_ID=$(wezterm cli list --format json | jq -r --arg title "$PANE_TITLE" '.[] | select(.title == $title) | .pane_id')

if [ -z "$PANE_ID" ]; then
  wezterm cli split-pane --bottom --percent 50 -- sh -c "echo -ne '\\033]2;$PANE_TITLE\\007'; zsh"
else
  wezterm cli activate-pane --pane-id "$PANE_ID"
fi


