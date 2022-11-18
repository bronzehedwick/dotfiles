#!/usr/bin/env fish

function today
  calendar -A 0 -f /usr/share/calendar/calendar.lotr
  calendar -A 0 -f /usr/share/calendar/calendar.world
  calendar -A 0 -f /usr/share/calendar/calendar.music
  calendar -A 0 -f /usr/share/calendar/calendar.freebsd
  calendar -A 0 -f /usr/share/calendar/calendar.computer
end
