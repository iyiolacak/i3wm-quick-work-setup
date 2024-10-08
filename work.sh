#!/bin/bash

# i3 workspace automation script

# Move the terminal (from which this script is executed) to Workspace 6
i3-msg "move container to workspace 6"

# Function to clear out specific windows in a workspace based on class or title (avoiding terminal windows)
clear_workspace() {
  workspace=$1
  # Kill only specific windows, avoiding accidental terminal window closure
  i3-msg "workspace $workspace; focus"
  i3-msg "[class=\"firefox\"] kill"
  i3-msg "[class=\"Code\"] kill"
  i3-msg "[title=\"Spotify Premium\"] kill"   # Using window title for Spotify
  i3-msg "[title=\"Telegram\"] kill"          # Using window title for Telegram
}

# Ensure all workspaces are clear of unnecessary windows
clear_workspace 1
clear_workspace 2
clear_workspace 3
clear_workspace 4
clear_workspace 5

# Small delay to ensure processes are killed
sleep 2

# Workspace 1 - Firefox (Main Browser)
i3-msg "workspace 1; exec firefox"
sleep 3  # Give Firefox time to start

# Workspace 2 - VSCode and Firefox (ChatGPT) with horizontal split
i3-msg "workspace 2; exec code"
sleep 3  # Giving more time for VSCode to open
i3-msg "split h"
i3-msg "exec firefox --new-window https://chat.openai.com"
sleep 3  # Adjusted for Firefox opening

# Ensure VSCode and Firefox are in the correct workspace and layout
i3-msg "[class=\"Code\"] focus"
i3-msg "move container to workspace 2"
i3-msg "[class=\"firefox\"] focus"
i3-msg "move container to workspace 2"

# Resize windows in workspace 2 (VSCode 60%, Firefox 40%)
i3-msg "workspace 2; layout splith"
i3-msg "focus left"
i3-msg "resize set 60 ppt 100 ppt"
i3-msg "focus right"
i3-msg "resize set 40 ppt 100 ppt"

# Workspace 3 - Notion
i3-msg "workspace 3; exec firefox --new-window https://www.notion.so/"
sleep 3  # Give Firefox time to start

# Workspace 4 - Spotify (Flatpak)
i3-msg "workspace 4; exec flatpak run com.spotify.Client"
sleep 3  # Give Spotify time to start

# Workspace 5 - Telegram (Flatpak)
i3-msg "workspace 5; exec flatpak run org.telegram.desktop"
sleep 3  # Give Telegram time to start

# Return to Workspace 2 (Coding workspace)
i3-msg "workspace 2"

echo "Workspace setup complete."


# Gracefully kill the Kitty terminal
KITTY_PID=$(pgrep -x kitty)
if [ -n "$KITTY_PID" ]; then
  kill -15 $KITTY_PID  # Graceful termination using SIGTERM
  wait $KITTY_PID      # Prevent zombie processes by waiting for it to exit
fi
