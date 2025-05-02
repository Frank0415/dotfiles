#!/bin/sh

for i in $(seq 10); do
  if xsetwacom list devices | grep -q Wacom; then
    break
  fi
done

xsetwacom set "Wacom One by Wacom M Pen stylus" Button 2 "key +ctrl z -ctrl"
xsetwacom set "Wacom One by Wacom M Pen stylus" Button 3 "key +Shift +ctrl p -ctrl -Shift"
xsetwacom set "Wacom One by Wacom M Pen stylus" PressureCurve 0 0 0 100
xsetwacom set "Wacom One by Wacom M Pen stylus" PressureCurve 0 100 100 100

