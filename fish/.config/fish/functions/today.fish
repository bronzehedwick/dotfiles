#!/usr/bin/env fish

function today
  calendar -A 0 -f /usr/local/share/calendar/calendar.lotr
  calendar -A 0 -f /usr/local/share/calendar/calendar.world
  calendar -A 0 -f /usr/local/share/calendar/calendar.music
  calendar -A 0 -f /usr/local/share/calendar/calendar.computer
end
