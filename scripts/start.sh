#!/bin/bash

# Function to find package.json or index.html up the directory tree
find_up() {
    local file=$1
    local current=$(pwd)

    while [[ "$current" != "/" ]]; do
        if [[ -f "$current/$file" ]]; then
            echo "$current"
            return
        fi
        current=$(dirname "$current")
    done
}

run_in_iterm() {
    local directory=$1
    local command=$2
    osascript <<EOF
tell application "iTerm"
    tell current window
        create tab with default profile
        tell the current session
            write text "cd '$directory' && $command"
        end tell
    end tell
end tell
EOF
}

# Try to find package.json and read command from scripts
find_package_json=$(find_up "package.json")
if [[ -n $find_package_json ]]; then
    cd "$find_package_json"
    if grep -q '"dev":' package.json; then
        run_in_iterm "$find_package_json" "npm run dev"
    elif grep -q '"start":' package.json; then
        run_in_iterm "$find_package_json" "npm start"
    else
        echo "No 'dev' or 'start' script found in package.json."
        exit 1
    fi
    exit
fi

# Fallback to looking for index.html and running live-server
find_index_html=$(find_up "index.html")
if [[ -n $find_index_html ]]; then
    run_in_iterm "$find_index_html" "live-server"
else
    echo "Unable to start project: No valid 'package.json' or 'index.html' found."
    exit 1
fi
