#!/usr/bin/env bash

RESURRECT_DIR="$HOME/.tmux-resurrect"
SAVE_FILE="$RESURRECT_DIR/last"

# 1. Pick a session
SESSION=$(tmux list-sessions -F "#{session_name}" | sort | fzf --prompt="Delete session permanently > ")

if [ -z "$SESSION" ]; then
    tmux display-message "Canceled."
    exit 0
fi

# 2. Kill the tmux session
tmux kill-session -t "$SESSION"

# 3. Remove the session block from the resurrect save file
# Each session block starts with a 'session_name name' line
TMP=$(mktemp)

awk -v target="session_name $SESSION" '
    $0 == target {skip=1}
    skip && /^window/ {next}
    skip && !/^window/ {skip=0; next}
    !skip
' "$SAVE_FILE" > "$TMP"

mv "$TMP" "$SAVE_FILE"

# 4. Force regenerate save
$HOME/.tmux/plugins/tmux-resurrect/scripts/save.sh > /dev/null 2>&1

# 5. Notify
tmux display-message "Session '$SESSION' permanently deleted."

