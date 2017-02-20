# =======
# Imports
# =======

import tables
import sequtils

import "logger.nim"
import "actions.nim"
import "command.nim"
import "termbox.nim"
import "windows.nim"
import "bindings.nim"
import "constants.nim"

# =========
# Functions
# =========

proc processInput*(window: var Window, keyMapping: seq[UserKeyBinding]): bool = 
  var event: tb_event
  discard tb_poll_event(addr event)
  var mapped_action = ""
  case event.`type`
  of TB_EVENT_MOUSE:
    discard
  of TB_EVENT_KEY:
    let key_string = bindings.translate(event)
    if key_string.len > 0:
      let found_mapped_actions = sequtils.filter(keyMapping, proc(x: UserKeyBinding): bool = (x.key == key_string))
      if found_mapped_actions.len > 0:
        if found_mapped_actions.len > 1:
          Logger(Warn, "this key has more than one binding associated with it, the last one defined in the config file will be used")
        mapped_action = found_mapped_actions[^1].action
  of TB_EVENT_RESIZE:
    mapped_action = Command_Reload
  else:
    discard
  let values: seq[string] = sequtils.toSeq(CommandMap.keys())
  if mapped_action in values:
    let command_string: string = CommandMap[mapped_action]
    return command.perform(window, command_string, @[])
  else:
    Logger(Warn, "unknown command!")
  return true
