#!/bin/bash

# i3 workspace automation script

# Function to clear out specific windows in a workspace based on class or title (avoiding terminal windows)
clear_workspace() {
  workspace=$1
  # Kill only specific windows, avoiding accidental terminal window closure
  i3-msg "workspace $workspace; focus"
  i3-msg "[class=\"firefox\"] kill"
  i3-msg "[class=\"Code\"] kill"
  i3-msg "[class=\"spotify\"] kill"
  i3-msg "[class=\"telegram-desktop\"] kill"
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
sleep 2 # Adjusted for slower startup

# Workspace 2 - VSCode and Firefox (ChatGPT) with horizontal split
i3-msg "workspace 2; exec code"
sleep 3 # Giving more time for VSCode to open
i3-msg "split h"
i3-msg "exec firefox --new-window https://chat.openai.com"
sleep 3 # Adjusted for Firefox opening

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
sleep 2

# Workspace 4 - Spotify
i3-msg "workspace 4; exec spotify"
sleep 2

# Workspace 5 - Telegram
i3-msg "workspace 5; exec telegram-desktop"
sleep 2

# Return to Workspace 2 (Coding workspace)
i3-msg "workspace 2"

echo "Workspace setup complete."
