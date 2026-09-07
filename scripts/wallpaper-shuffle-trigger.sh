#!/usr/bin/env bash
PID_FILE="$HOME/.local/state/wallpaper-shuffle/daemon.pid"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    kill -USR1 "$(cat "$PID_FILE")"
else
    echo "wallpaper-shuffle daemon isn't running - check: launchctl list | grep wallpapershuffle" >&2
    exit 1
fi
