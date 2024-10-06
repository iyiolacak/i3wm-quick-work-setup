#!/bin/bash

# i3 workspace automation script
# this script clears specified workspaces and sets up a pre-defined workspace layout with specific apps.
# customizable to your needs. use it as a template for your workspace management.

# function to clear out windows in a workspace
clear_workspace() {
  workspace=$1
  i3-msg "workspace $workspace; focus; [con_id=__focused__] kill"
}

# delay to ensure that all windows are fully closed before continuing
sleep 1

# clear windows in the specified workspaces
clear_workspace 1
clear_workspace 2
clear_workspace 3
clear_workspace 4
clear_workspace 5

# small delay to ensure the clearing is completed
sleep 1

# launch firefox in workspace 1 (main browser workspace)
i3-msg "workspace 1; exec firefox"

# setup vscode and firefox (chatGPT) in workspace 2 with a horizontal split
i3-msg "workspace 2; exec code"
sleep 2 # give vscode time to open
i3-msg "split h" # split horizontally
i3-msg "exec firefox --new-window https://chat.openai.com"
sleep 2 # give firefox time to open

# ensure vscode and firefox are in the correct layout and resize them
i3-msg "[class=\"Code\"] focus"
i3-msg "move container to workspace 2"
i3-msg "[class=\"firefox\"] focus"
i3-msg "move container to workspace 2"

# adjust window sizes in workspace 2: vscode (60%) and firefox (40%)
i3-msg "workspace 2; layout splith"
i3-msg "focus left"
i3-msg "resize set 60 ppt 100 ppt"
i3-msg "focus right"
i3-msg "resize set 40 ppt 100 ppt"

# launch notion in workspace 3
i3-msg "workspace 3; exec firefox --new-window https://www.notion.so/"

# launch spotify in workspace 4
i3-msg "workspace 4; exec spotify"

# launch telegram in workspace 5
i3-msg "workspace 5; exec telegram-desktop"

# return to coding workspace(workspace 2) after setup
i3-msg "workspace 2"

echo "Workspace setup complete."
