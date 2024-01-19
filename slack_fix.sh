#!/bin/bash

# Run after updating slack from .deb file
# Works on slack 4.35.131

# Function to create a local slack desktop file
# Ensures that WebRTC is properly enabled when launching slack
# This should persist through slack updates
update_desktop_file() {
    local default_slack=$(find /usr -type f -name '*slack*.desktop')
    local local_slack="${HOME}/.local/share/applications/slack.desktop"

    echo "Found: $default_slack"
    echo "Copy to: $local_slack"

    # Check if local desktop file already has the required flag
    if grep -q -- "--enable-features=WebRTCPipeWireCapturer" "$local_slack"; then
        echo "Local desktop file already updated."
    else
      # Create or update local version of slack launcher
      cp -p "$default_slack" "$local_slack" && \
      sudo sed -i -e \
        's|/slack %U|/slack --enable-features=WebRTCPipeWireCapturer %U|' \
        "$local_slack" && \
        echo "Added --enable-features flag"
    fi
}

# Function to update asar file
# Slack explicitly disable the WebRTC flag we need
# The file MUST be the same length, so we change a single letter to invalidate
#   the flag.
# Does not work with Snap install as the snap dir is Read-Only
update_asar_file() {
    local asar_file=$(find /usr -type f -name app.asar | grep slack)

    # Check if asar file already has the corrected flag
    if grep -q -- ',"LebRTCPipeWireCapturer' "$asar_file"; then
        echo "Slack app.assar desktop file already updated."
    else
      echo "Fixing file: $asar_file"
      sudo sed -i -e \
        's/,"WebRTCPipeWireCapturer"/,"LebRTCPipeWireCapturer"/' \
        "$asar_file" && \
        echo "Done"
    fi
}

echo "Updating Slack to allow screensharing on Ubuntu22.04..."
update_desktop_file || { echo "Failed to update desktop file."; exit 1; }
update_asar_file || { echo "Failed to update asar file."; exit 1; }

echo "Update complete."
