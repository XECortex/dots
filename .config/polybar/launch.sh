#! /bin/bash

# Terminate already running bar instances
polybar-msg cmd quit

# Launch polybar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar primary 2>&1 | tee -a /tmp/polybar1.log & disown
polybar secondary 2>&1 | tee -a /tmp/polybar2.log & disown