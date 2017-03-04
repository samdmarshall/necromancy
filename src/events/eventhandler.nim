# =======
# Imports
# =======

import tables
import sequtils

import "actions.nim"
import "command.nim"
import "bindings.nim"
import "constants.nim"

import "../logger.nim"
import "../termbox.nim"

import "../models/types.nim"

import "../ui/view.nim"
import "../ui/textview.nim"

# =========
# Functions
# =========

proc processInput*(screen: Window, config: Configuration): bool =
  var mapped_action = ""
  var event: tb_event
  discard tb_poll_event(addr event)
  let bound_key = translate(event)
  case event.`type`
  of TB_EVENT_MOUSE:
    discard
  of TB_EVENT_KEY:
    writeToDebugConsole(screen, bound_key)
  of TB_EVENT_RESIZE:
    mapped_action = Command_Reload
  else:
    discard
  if bound_key.len > 0:
    let found_mapped_actions = sequtils.filter(config.keys, proc(x: UserKeyBinding): bool = (x.key == bound_key))
    if found_mapped_actions.len > 0:
      if found_mapped_actions.len > 1:
        Logger(Warn, "this key has more than one binding associated with it, the last one defined in the config file will be used")
      mapped_action = found_mapped_actions[^1].action
  if mapped_action in CommandMap:
    let command_string: string = CommandMap[mapped_action]
    return command.perform(screen, command_string, @[])
  else:
    Logger(Warn, "unknown command!")
  return true