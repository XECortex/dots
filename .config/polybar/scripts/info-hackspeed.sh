#!/usr/bin/env sh

KEYBOARD_ID="8"
FORMAT="󰌓 %d wpm"
INTERVAL=10
CONDITION='($3 >= 10 && $3 <= 20) || ($3 >= 24 && $3 <= 34) || ($3 == 36) || ($3 >= 38 && $3 <= 48) || ($3 >= 52 && $3 <= 58)'

multiply_by=60
divide_by=$(($INTERVAL * 5))

# Create a temp file
hackspeed_cache="$(mktemp -p '' hackspeed_cache.XXXXX)"
trap 'rm "$hackspeed_cache"' EXIT

# Write a dot to our cache for each key press
printf '' > "$hackspeed_cache"
xinput test "$KEYBOARD_ID" | stdbuf -o0 awk '$1 == "key" && $2 == "press" && ('"$CONDITION"') {printf "."}' >> "$hackspeed_cache" &

while true; do
	lines=$(stat --format %s "$hackspeed_cache")
	printf '' > "$hackspeed_cache"
	value=$((lines * multiply_by / divide_by))

	printf "$FORMAT\\n" "$value"

	sleep $INTERVAL
done