#!/usr/bin/env bash

# highlights the workspace item that matches the currently focused one
# $1 is this item's own workspace number (passed in from the sketchybarrc loop)
# $FOCUSED_WORKSPACE comes from the event triggered by aerospace
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color=0xff26bbd9 icon.color=0xff1c1e26
else
    sketchybar --set $NAME background.color=0x44666666 icon.color=0xffd5d8da
fi
