#!/usr/bin/env sh

status() {
  MUTED=$(pactl list sources | awk '/Mute/ {print $2; exit}')

  if [ "$MUTED" = "yes" ]; then
    echo "%{F#73bbc3c8}󰍭%{F-}"
  else
    echo "󰍬"
  fi
}

listen() {
    status

    LANG=EN; pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
            status
        fi
    done
}

toggle() {
  MUTED=$(pactl list sources | awk '/Mute/ {print $2; exit}')

  if [ "$MUTED" = "yes" ]; then
      pactl set-source-mute @DEFAULT_SOURCE@ 0
  else
      pactl set-source-mute @DEFAULT_SOURCE@ 1
  fi
}

case "$1" in
    --toggle)
        toggle
        ;;
    *)
        listen
        ;;
esac