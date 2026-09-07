#!/usr/bin/env bash
# background daemon: rotates desktop wallpaper on a timer, and immediately
# (resetting the timer) whenever it receives SIGUSR1 from the trigger script
set -u

WALLPAPER_DIR="$HOME/wallpapers"
STATE_DIR="$HOME/.local/state/wallpaper-shuffle"
PID_FILE="$STATE_DIR/daemon.pid"
INTERVAL=1800  # s

mkdir -p "$STATE_DIR"
echo $$ > "$PID_FILE"

pick_and_set_wallpaper() {
    local current pick
    current=$(/usr/local/bin/desktoppr 2>/dev/null | head -n1)

    local candidates=()
    while IFS= read -r -d '' f; do
        [ "$f" != "$current" ] && candidates+=("$f")
    done < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.heic' \) -print0)

    # only one wallpaper total: allow repeating it rather than finding nothing
    if [ "${#candidates[@]}" -eq 0 ]; then
        while IFS= read -r -d '' f; do
            candidates+=("$f")
        done < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.heic' \) -print0)
    fi

    [ "${#candidates[@]}" -eq 0 ] && { echo "no wallpapers found in $WALLPAPER_DIR" >&2; return 1; }

    pick="${candidates[$(jot -r 1 0 $((${#candidates[@]} - 1)))]}"
        /usr/local/bin/desktoppr "$pick"
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
