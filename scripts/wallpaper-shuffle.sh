#!/usr/bin/env bash
# background daemon: rotates desktop wallpaper on a timer, and immediately
# (resetting the timer) whenever it receives SIGUSR1 from the trigger script
set -u

WALLPAPER_DIR="$HOME/wallpapers"
STATE_DIR="$HOME/.local/state/wallpaper-shuffle"
PID_FILE="$STATE_DIR/daemon.pid"
INTERVAL=1800  # s
CURRENT_INDEX=-1

mkdir -p "$STATE_DIR"
echo $$ > "$PID_FILE"

pick_and_set_wallpaper() {
    local wallpapers=()
    while IFS= read -r -d '' f; do
        wallpapers+=("$f")
    done < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.heic' \) -print0 | sort -z)

    [ "${#wallpapers[@]}" -eq 0 ] && { echo "no wallpapers found in $WALLPAPER_DIR" >&2; return 1; }

    CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % ${#wallpapers[@]} ))
    /usr/local/bin/desktoppr "${wallpapers[$CURRENT_INDEX]}"
}

SLEEP_PID=""
on_signal() { [ -n "$SLEEP_PID" ] && kill "$SLEEP_PID" 2>/dev/null; }
trap on_signal SIGUSR1

while true; do
    pick_and_set_wallpaper
    sleep "$INTERVAL" &
    SLEEP_PID=$!
    wait "$SLEEP_PID"
done
